from subprocess import DEVNULL, STDOUT, check_call
import numpy as np
import matplotlib.pyplot as plt
import re

class Parser:

    def __init__(self):
        self.tclFile = "wireless.tcl"
        self.trFile = "wireless.tr"
        self.th6 = "throughput6.tr"
        self.th7 = "throughput7.tr"
        self.th8 = "throughput8.tr"
        self.th9 = "throughput9.tr"
        self.th10 = "throughput10.tr"
        self.packetPattern = '^([srd]) -t ([0-9]*[.]?[0-9]*) .*-Hs (\d+) .*-Ii (\d+) .*'
        self.tcpPattern = '^[dsr].*-It tcp.*'
        self.packetCount = 0
        return

    def runCommand(self, errorRate, bw):
        print("Running for errorRate: " + str(errorRate) + "\tBW: " + str(bw))
        check_call(['ns', self.tclFile, str(errorRate), str(bw)], stdout=DEVNULL,
                    stderr=STDOUT)

    def plot(self, data, superTitle, subTitle, x_ax, y_ax):
        plt.figure(figsize = (15, 6))
        keys = list(data.keys())
        values = list(data.values())
        for i in range(len(keys)):
            plt.subplot(1, 4, i + 1)
            plt.suptitle(superTitle)
            plt.title(subTitle + str(keys[i]))
            pointsX = [i[0] for i in values[i]]
            pointsY = [i[1] for i in values[i]]
            plt.xlim([float(0.9* min(pointsX)), float(1.1*max(pointsX))])
            plt.ylim([float(0.9*min(pointsY)), float(1.1*max(pointsY))])
            plt.plot(pointsX, pointsY, marker = 'o')
            plt.ylabel(y_ax)
            plt.xlabel(x_ax)
        plt.show()

    def checkStatus(self, whichPacketErrored, 
    resultMatched, sentTimes, retransmittedPackets, arrivalTimes):
        status = resultMatched.group(1)
        time = resultMatched.group(2)
        hs = resultMatched.group(3)
        uid = resultMatched.group(4)

        if status == 's':
            if re.search('[5]', hs):  # sender should be 5
                if uid not in sentTimes:
                    sentTimes[uid] = time  # packet is sent now!
                    self.packetCount += 1
            if self.packetCount == whichPacketErrored: 
                retransmittedPackets.append(uid)
                self.packetCount = 0
                
        elif status == 'r':
            if uid in sentTimes:
                if re.search('[6789]', hs): # receivers should be 6 7 8 9 10
                    propdelay = (float(time) - float(sentTimes[uid]))
                    if uid in retransmittedPackets:
                        arrivalTimes[uid] = 2*propdelay
                    else:
                        arrivalTimes[uid] = propdelay        

    def calcAvgDelay(self, whichPacketErrored):
        openTRFile = open(self.trFile, "r")
        data = []
        sentTimes = {}
        arrivalTimes = {}
        retransmittedPackets = []
        for row in openTRFile:
            data.append(str(row))
        for pattern in row:
            if re.search(self.tcpPattern, pattern):
                data.append(pattern)
        self.packetCount = 0
        for line in data:
            resultMatched = re.search(self.packetPattern, line)
            if not resultMatched: continue
            self.checkStatus(whichPacketErrored, resultMatched, 
            sentTimes, retransmittedPackets, arrivalTimes)
        return sum(arrivalTimes.values()) / len(arrivalTimes)


    def calcThroughput(self):
        through6 = np.genfromtxt(self.th6, dtype=np.int32)
        through7 = np.genfromtxt(self.th7, dtype=np.int32)
        through8 = np.genfromtxt(self.th8, dtype=np.int32)
        through9 = np.genfromtxt(self.th9, dtype=np.int32)
        through10 = np.genfromtxt(self.th10, dtype=np.int32)
        totalThrougput = np.sum(through6[:, 1], dtype=np.int32) + np.sum(through7[:, 1], dtype=np.int32) + np.sum(through8[:, 1], dtype=np.int32) + np.sum(through9[:, 1], dtype=np.int32) + np.sum(through10[:, 1], dtype=np.int32)
        totalThrougput = float(totalThrougput/5000) #Kb
        return totalThrougput