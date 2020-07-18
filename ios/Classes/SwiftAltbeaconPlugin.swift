import Flutter
import UIKit

public class SwiftAltbeaconPlugin: NSObject, FlutterPlugin, AltBeaconDelegate {
    
  private var altBeacon: AltBeacon?
  private var eventSinkRanging, eventSinkMonitoring: FlutterEventSink?
  private var eventChannel, eventChannelMonitoring: FlutterEventChannel?
  private var regionRanging: [AnyHashable]?
  private var regionMonitoring: [AnyHashable]?
  private var flutterResult: FlutterResult?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let messenger = registrar.messenger()
    let channel = FlutterMethodChannel(name: "altbeacon", binaryMessenger: messenger)
    let instance = SwiftAltbeaconPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    
    
    instance.eventChannel = FlutterEventChannel(name: "flutter_beacon_event", binaryMessenger: registrar.messenger())
    instance.eventChannel?.setStreamHandler(AltBeaconRangingStreamHandler(ref: instance))
    
    instance.eventChannelMonitoring = FlutterEventChannel(name: "flutter_beacon_event_monitoring", binaryMessenger: registrar.messenger())
    instance.eventChannelMonitoring?.setStreamHandler(AltBeaconMonitoringStreamHandler(ref: instance))
  }
  
  class AltBeaconRangingStreamHandler: NSObject, FlutterStreamHandler {
          
    var swiftAltBeaconPlugin: SwiftAltbeaconPlugin
    
    init(ref: SwiftAltbeaconPlugin) {
      self.swiftAltBeaconPlugin = ref
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
       self.swiftAltBeaconPlugin.startRanging(withArguments: arguments, eventSink: events)
      return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
      return nil
    }
    
  }

  
  class AltBeaconMonitoringStreamHandler: NSObject, FlutterStreamHandler {
    
    var swiftAltBeaconPlugin: SwiftAltbeaconPlugin
    
    init(ref: SwiftAltbeaconPlugin) {
      self.swiftAltBeaconPlugin = ref
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
      self.swiftAltBeaconPlugin.startMonitoring(withArguments: arguments, eventSink: events)
      return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
      return nil
    }
    
  }
  

  

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    print("handle")
    switch call.method {
      case "initialize":
        self.initialize()
        result(true)
        return;
      case "initializeAndCheck":
        break
      case "authorizationStatus":
        break
      case "checkLocationServicesIfEnabled":
        break
      case "bluetoothState":
        break
      case "requestAuthorization":
        break
      case "openBluetoothSettings":
        break
      case "openLocationSettings":
        break
      case "openApplicationSettings":
        break
      default:
        break
    }
  }
    
//    if (o instanceof List) {
//      List list = (List) o;
//      if (regionRanging == null) {
//        regionRanging = new ArrayList<>();
//      } else {
//        regionRanging.clear();
//      }
//      for (Object object : list) {
//        if (object instanceof Map) {
//          Map map = (Map) object;
//          Region region = FlutterBeaconUtils.regionFromMap(map);
//          if (region != null) {
//            regionRanging.add(region);
//          }
//        }
//      }
//    } else {
//      eventSink.error("Beacon", "invalid region for ranging", null);
//      return;
//    }
  
  private func startRanging(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) {
    eventSinkRanging = events
    if arguments is Array<Any> {
      let list = arguments as! Array<Any>
      if (regionRanging == nil) {
        regionRanging = Array()
      } else {
        regionRanging?.removeAll()
      }
      eventSinkRanging = events
      
      let array = arguments as? [AnyHashable]
      for dict in array ?? [] {
          guard let dict = dict as? [AnyHashable : Any] else {
              continue
          }
        let region = FBUtils.region(fromDictionary: dict)

          if region != nil {
              if let region = region {
                regionRanging?.append(region)
              }
          }
      }
    }
  }
  
  private func startMonitoring(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) {
    
  }
      
  private func initialize() {
    print("initialize")
    altBeacon = AltBeacon(identifier: "5F22CA05-8F6C-49B6-AEAE-B278FDFE9287")
    startRangingBeacon(withCall: nil)
    startMonitoringBeacon(withCall: nil)
  }

  func startRangingBeacon(withCall arguments: Any?) {
    altBeacon?.startBroadcasting()
  }
  
  func startMonitoringBeacon(withCall arguments: Any?) {
    altBeacon?.startDetecting()
    altBeacon?.add(self)
  }
  private func stopRangingBeacon() {
    altBeacon?.stopBroadcasting()
  }
  private func stopMonitoringBeacon() {
    altBeacon?.stopDetecting()
  }
  
  public func service(_ service: AltBeacon!, foundDevices devices: NSMutableDictionary!) {
    print("Monitoring:...")
    if (eventSinkRanging != nil){
      eventSinkRanging!(devices)
    }
    for key in devices {
      let range = devices[key] as? NSNumber
      
      if range?.intValue ?? 0 == INDetectorRangeUnknown.rawValue {
        
//            if key == kUuidBeaconOne {
//                labelDisplayResultBeacon1.text = ""
//            } else if key == kUuidBeaconTwo {
//                labelDisplayResultBeacon2.text = ""
//            } else if key == kUuidBeaconThree {
//                labelDisplayResultBeacon3.text = ""
//            }
      } else {

//            let result = convert(toString: range)
//            var beaconName = ""
//            if key == kUuidBeaconOne {
//                beaconName = "Beacon one!"
//                labelDisplayResultBeacon1.text = "\(beaconName) \("was found") \(result) \("meters away")"
//            } else if key == kUuidBeaconTwo {
//                beaconName = "Beacon two!"
//                labelDisplayResultBeacon2.text = "\(beaconName) \("was found") \(result) \("meters away")"
//            } else if key == kUuidBeaconThree {
//                beaconName = "Beacon three!"
//                labelDisplayResultBeacon3.text = "\(beaconName) \("was found") \(result) \("meters away")"
//            }
      }
    }
  }
  
  public func service(_ service: AltBeacon!, bluetoothAvailable enabled: Bool) {
    
  }
}
