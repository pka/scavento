#include <Ethernet.h>

// network configuration.  gateway and subnet are optional.
byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
byte ip[] = { 192, 168, 1, 99 };
byte gateway[] = { 192, 168, 1, 1 };
byte subnet[] = { 255, 255, 255, 0 };

byte server[] = { 192, 168, 1, 108 }; // Test server
int port = 3000; // Test port

int station_id = 100;

Client client(server, port);

void setup_request(int station_id, long value)
{
  client.print("GET /samples?station_id=");
  client.print(station_id);
  client.print("&value=");
  client.print(value);
  client.println(" HTTP/1.0");
  client.println();
}

void setup()
{
  // initialize the ethernet device
  Ethernet.begin(mac, ip, gateway, subnet);
  Serial.begin(9600);
  randomSeed(analogRead(0));
  
  delay(1000);

  Serial.println("connecting...");
  
  if (client.connect()) {
    Serial.println("connected");
    setup_request(station_id, random(999));
  } else {
    Serial.println("connection failed");
  }
}

void loop()
{
  if (client.available()) {
    char c = client.read();
    Serial.print(c);
    
    if (!client.available()) {
      Serial.println("preparing next value...");
      client.stop();
      delay(2000);
      client.connect();
      setup_request(station_id, random(999));
    }
  }
  
  if (!client.connected()) {
    Serial.println();
    Serial.println("disconnecting.");
    client.stop();
    for(;;)
      ;
  }
}
