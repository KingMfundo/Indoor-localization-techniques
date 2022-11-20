#include <SPI.h>
#include <WiFiNINA.h>
#include <LiquidCrystal.h>

// initialize the library by associating any needed LCD interface pin
// with the arduino pin number it is connected to
const int rs = 12, en = 11, d4 = 5, d5 = 4, d6 = 3, d7 = 2;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);
void setup() {
  lcd.begin(20,4);
  //Initialize serial and wait for port to open:
  Serial.begin(9600);
  lcd.print("Indoor localization");
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  // check for the WiFi module:
  if (WiFi.status() == WL_NO_MODULE) {
    Serial.println("Communication with WiFi module failed!");
    lcd.print("Communication with WiFi module failed!");
    // don't continue
    while (true);
  }

  String fv = WiFi.firmwareVersion();
  if (fv < WIFI_FIRMWARE_LATEST_VERSION) {
    Serial.println("Please upgrade the firmware");
    lcd.print("Please upgrade the firmware");
  }

  // print your MAC address:
  byte mac[6];
  WiFi.macAddress(mac);
  Serial.print("MAC: ");
  lcd.print("MAC: ");
  printMacAddress(mac);
}

void loop() {
  lcd.setCursor(0,1);
  // scan for existing networks:
  Serial.println("Scanning available networks...");
  lcd.print("Scanning available networks...");
  listNetworks();
  delay(10000);
}


void listNetworks() {
  // scan for nearby networks:
  Serial.println("** Scan Networks **");
  lcd.print("** Scan Networks **");
  int numSsid = WiFi.scanNetworks();
  if (numSsid == -1) {
    Serial.println("Couldn't get a wifi connection");
    lcd.print("Couldn't get a wifi connection");
    while (true);
  }

  // print the list of networks seen:
  Serial.print("number of available networks:");
  lcd.print("number of available networks:");
  Serial.println(numSsid);
  lcd.print("number of available networks:");
  //lcd.autoscroll();
  // print the network number and name for each network found:
  for (int thisNet = 0; thisNet < numSsid; thisNet++) {
    Serial.print(thisNet);
    Serial.print(") ");
    Serial.print(WiFi.SSID(thisNet));
    Serial.print("\tSignal: ");
    Serial.print(WiFi.RSSI(thisNet));
    Serial.print(" dBm");
     Serial.print("\t Distance to : ");
     float x=pow(10,(-55-float(WiFi.RSSI(thisNet)))/20);
     Serial.print(x);
      Serial.print(" m");
    Serial.print("\tEncryption: ");
    printEncryptionType(WiFi.encryptionType(thisNet));




   lcd.print(thisNet);
    lcd.print(") ");
    lcd.print(WiFi.SSID(thisNet));
    lcd.print("\tSignal: ");
    lcd.print(WiFi.RSSI(thisNet));
    lcd.print(" dBm");
     lcd.print("\t Distance to : ");
    // float x=pow(10,(-55-float(WiFi.RSSI(thisNet)))/20);
     lcd.print(x);
      lcd.print(" m");
    lcd.print("\tEncryption: ");
    printEncryptionType(WiFi.encryptionType(thisNet));
  }
}

void printEncryptionType(int thisType) {
  // read the encryption type and print out the title:
  switch (thisType) {
    case ENC_TYPE_WEP:
      Serial.println("WEP");
      lcd.print("WEP");
      break;
    case ENC_TYPE_TKIP:
      Serial.println("WPA");
      lcd.print("WPA");
      break;
    case ENC_TYPE_CCMP:
      Serial.println("WPA2");
      lcd.print("WPA2");
      break;
    case ENC_TYPE_NONE:
      Serial.println("None");
      lcd.print("None");
      break;
    case ENC_TYPE_AUTO:
      Serial.println("Auto");
      lcd.print("Auto");
      break;
    case ENC_TYPE_UNKNOWN:
    default:
      Serial.println("Unknown");
      lcd.print("Unknown");
      break;
  }
}

void printMacAddress(byte mac[]) {
  for (int i = 5; i >= 0; i--) {
    if (mac[i] < 16) {
      Serial.print("0");
      lcd.print("0");
    }
    Serial.print(mac[i], HEX);
    lcd.print(mac[i], HEX);
    if (i > 0) {
      Serial.print(":");
      lcd.print(":");
    }
  }
  Serial.println();
}
