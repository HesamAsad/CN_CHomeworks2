
#ifdef NS3_MODULE_COMPILATION
# error "Do not include ns3 module aggregator headers from other modules; these are meant only for end user scripts."
#endif

#ifndef NS3_MODULE_WIFI
    

// Module headers:
#include "aarf-wifi-manager.h"
#include "aarfcd-wifi-manager.h"
#include "adhoc-wifi-mac.h"
#include "ampdu-subframe-header.h"
#include "ampdu-tag.h"
#include "amrr-wifi-manager.h"
#include "amsdu-subframe-header.h"
#include "ap-wifi-mac.h"
#include "aparf-wifi-manager.h"
#include "arf-wifi-manager.h"
#include "athstats-helper.h"
#include "block-ack-agreement.h"
#include "block-ack-manager.h"
#include "block-ack-type.h"
#include "block-ack-window.h"
#include "capability-information.h"
#include "cara-wifi-manager.h"
#include "channel-access-manager.h"
#include "constant-obss-pd-algorithm.h"
#include "constant-rate-wifi-manager.h"
#include "ctrl-headers.h"
#include "dsss-error-rate-model.h"
#include "dsss-parameter-set.h"
#include "dsss-phy.h"
#include "dsss-ppdu.h"
#include "edca-parameter-set.h"
#include "erp-information.h"
#include "erp-ofdm-phy.h"
#include "erp-ofdm-ppdu.h"
#include "error-rate-model.h"
#include "error-rate-tables.h"
#include "extended-capabilities.h"
#include "frame-capture-model.h"
#include "frame-exchange-manager.h"
#include "he-capabilities.h"
#include "he-configuration.h"
#include "he-frame-exchange-manager.h"
#include "he-operation.h"
#include "he-phy.h"
#include "he-ppdu.h"
#include "he-ru.h"
#include "ht-capabilities.h"
#include "ht-configuration.h"
#include "ht-frame-exchange-manager.h"
#include "ht-operation.h"
#include "ht-phy.h"
#include "ht-ppdu.h"
#include "ideal-wifi-manager.h"
#include "interference-helper.h"
#include "mac-rx-middle.h"
#include "mac-tx-middle.h"
#include "mgt-headers.h"
#include "minstrel-ht-wifi-manager.h"
#include "minstrel-wifi-manager.h"
#include "mpdu-aggregator.h"
#include "msdu-aggregator.h"
#include "mu-edca-parameter-set.h"
#include "mu-snr-tag.h"
#include "multi-user-scheduler.h"
#include "nist-error-rate-model.h"
#include "obss-pd-algorithm.h"
#include "ofdm-phy.h"
#include "ofdm-ppdu.h"
#include "onoe-wifi-manager.h"
#include "originator-block-ack-agreement.h"
#include "parf-wifi-manager.h"
#include "phy-entity.h"
#include "preamble-detection-model.h"
#include "qos-blocked-destinations.h"
#include "qos-frame-exchange-manager.h"
#include "qos-txop.h"
#include "qos-utils.h"
#include "recipient-block-ack-agreement.h"
#include "regular-wifi-mac.h"
#include "rr-multi-user-scheduler.h"
#include "rraa-wifi-manager.h"
#include "rrpaa-wifi-manager.h"
#include "simple-frame-capture-model.h"
#include "snr-tag.h"
#include "spectrum-wifi-helper.h"
#include "spectrum-wifi-phy.h"
#include "ssid.h"
#include "sta-wifi-mac.h"
#include "status-code.h"
#include "supported-rates.h"
#include "table-based-error-rate-model.h"
#include "thompson-sampling-wifi-manager.h"
#include "threshold-preamble-detection-model.h"
#include "txop.h"
#include "vht-capabilities.h"
#include "vht-configuration.h"
#include "vht-frame-exchange-manager.h"
#include "vht-operation.h"
#include "vht-phy.h"
#include "vht-ppdu.h"
#include "wifi-ack-manager.h"
#include "wifi-acknowledgment.h"
#include "wifi-default-ack-manager.h"
#include "wifi-default-protection-manager.h"
#include "wifi-helper.h"
#include "wifi-information-element-vector.h"
#include "wifi-information-element.h"
#include "wifi-mac-header.h"
#include "wifi-mac-helper.h"
#include "wifi-mac-queue-item.h"
#include "wifi-mac-queue.h"
#include "wifi-mac-trailer.h"
#include "wifi-mac.h"
#include "wifi-mode.h"
#include "wifi-mpdu-type.h"
#include "wifi-net-device.h"
#include "wifi-phy-band.h"
#include "wifi-phy-common.h"
#include "wifi-phy-listener.h"
#include "wifi-phy-operating-channel.h"
#include "wifi-phy-state-helper.h"
#include "wifi-phy-state.h"
#include "wifi-phy.h"
#include "wifi-ppdu.h"
#include "wifi-protection-manager.h"
#include "wifi-protection.h"
#include "wifi-psdu.h"
#include "wifi-radio-energy-model-helper.h"
#include "wifi-radio-energy-model.h"
#include "wifi-remote-station-info.h"
#include "wifi-remote-station-manager.h"
#include "wifi-spectrum-phy-interface.h"
#include "wifi-spectrum-signal-parameters.h"
#include "wifi-standards.h"
#include "wifi-tx-current-model.h"
#include "wifi-tx-parameters.h"
#include "wifi-tx-timer.h"
#include "wifi-tx-vector.h"
#include "wifi-utils.h"
#include "yans-error-rate-model.h"
#include "yans-wifi-channel.h"
#include "yans-wifi-helper.h"
#include "yans-wifi-phy.h"
#endif
