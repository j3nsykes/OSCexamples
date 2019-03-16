{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 8,
			"minor" : 0,
			"revision" : 1,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ 288.0, 100.0, 862.0, 768.0 ],
		"bglocked" : 0,
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"lefttoolbarpinned" : 0,
		"toptoolbarpinned" : 0,
		"righttoolbarpinned" : 0,
		"bottomtoolbarpinned" : 0,
		"toolbars_unpinned_last_save" : 0,
		"tallnewobj" : 0,
		"boxanimatetime" : 200,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "",
		"digest" : "",
		"tags" : "",
		"style" : "",
		"subpatcher_template" : "",
		"boxes" : [ 			{
				"box" : 				{
					"id" : "obj-32",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 296.0, 69.0, 150.0, 47.0 ],
					"text" : "Example Arduino code for finding the device IP adress"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-29",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 8,
							"minor" : 0,
							"revision" : 1,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "box",
						"rect" : [ 59.0, 103.0, 640.0, 480.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-2",
									"linecount" : 93,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 20.0, 17.0, 491.0, 1253.0 ],
									"text" : "#include <Time.h>\n#include <ESP8266WiFi.h>\n#include <ESP8266mDNS.h>\n#include <WiFiClient.h>\n#include <ESP8266WebServer.h>\n\n#include <EEPROM.h>\n\n#include <Ticker.h>\n\nint status = WL_IDLE_STATUS;\n\nchar ssid[] = \"yournetworkname\";          // your network SSID (name)\nchar pass[] = \"yourpassword\";                    // your network password\n\nint keyIndex = 0;            // your network key Index number (needed only for WEP)\n\nunsigned int localPort = 2390;      // local port to listen on\n\nchar packetBuffer[255]; //buffer to hold incoming packet\nchar  ReplyBuffer[] = \"acknowledged\";       // a string to send back\n\nWiFiUDP Udp;\n\nvoid setup() {\n  //Initialize serial and wait for port to open:\n  Serial.begin(19200);\n\n\n  Serial.println(\"I'm awake\");\n  // attempt to connect to Wifi network:\n  WiFi.begin(ssid, pass);\n  Serial.println(\"\");\n\n  // Wait for connection\n  while (WiFi.status() != WL_CONNECTED) {\n    delay(500);\n    Serial.print(\".\");\n  }\n  Serial.println(\"Connected to wifi\");\n  printWifiStatus();\n\n  Serial.println(\"\\nStarting connection to server...\");\n  // if you get a connection, report back via serial:\n  Udp.begin(localPort);\n}\n\nvoid loop() {\n\n  // if there's data available, read a packet\n  int packetSize = Udp.parsePacket();\n  if (packetSize) {\n    Serial.print(\"Received packet of size \");\n    Serial.println(packetSize);\n    Serial.print(\"From \");\n    IPAddress remoteIp = Udp.remoteIP();\n    Serial.print(remoteIp);\n    Serial.print(\", port \");\n    Serial.println(Udp.remotePort());\n\n    // read the packet into packetBufffer\n    int len = Udp.read(packetBuffer, 255);\n    if (len > 0) {\n      packetBuffer[len] = 0;\n    }\n    Serial.println(\"Contents:\");\n    Serial.println(packetBuffer);\n\n    // send a reply, to the IP address and port that sent us the packet we received\n    Udp.beginPacket(Udp.remoteIP(), Udp.remotePort());\n    Udp.write(ReplyBuffer);\n    Udp.endPacket();\n  }\n}\n\n\nvoid printWifiStatus() {\n  // print the SSID of the network you're attached to:\n  Serial.print(\"SSID: \");\n  Serial.println(WiFi.SSID());\n\n  // print your WiFi shield's IP address:\n  IPAddress ip = WiFi.localIP();\n  Serial.print(\"IP Address: \");\n  Serial.println(ip);\n\n  // print the received signal strength:\n  long rssi = WiFi.RSSI();\n  Serial.print(\"signal strength (RSSI):\");\n  Serial.print(rssi);\n  Serial.println(\" dBm\");\n\n}"
								}

							}
 ],
						"lines" : [  ]
					}
,
					"patching_rect" : [ 299.0, 118.0, 86.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"tags" : ""
					}
,
					"text" : "p findIPDevice"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-27",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 8,
							"minor" : 0,
							"revision" : 1,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "box",
						"rect" : [ 59.0, 103.0, 640.0, 480.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-2",
									"linecount" : 109,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 31.0, 17.0, 558.0, 1468.0 ],
									"text" : "\n/*referenced from Sebastien Lexler example code*/\n/*Simplified and modified for teaching by Jen Sykes*/\n//ethernet, wifi libraries\n#include <ESP8266WiFi.h>\n#include <WiFiUdp.h>\n\n#include <SPI.h>\n#include <OSCBundle.h>\n\n//UDP communication\nWiFiUDP Udp;\n\n//the Arduino's IP\nconst IPAddress outIp(10, 1, 210, 50); // remote IP of your device not your laptop!!! use IPscanner or FIND_IP sketch to find this\nconst unsigned int localPort = 8888;        // local port to listen/receive OSC packets (not used for sending)\n\n\nchar ssid[] = \"yournetworkname\";          // your network SSID (name)\nchar pass[] = \"yourpassword\";                    // your network password\n\nint LEDon = 0;\nint pos;\nvoid setup() {\n  //setup ethernet part\n  Serial.begin(19200);\n\n  // Connect to WiFi network\n  Serial.println();\n  Serial.println();\n  Serial.print(\"Connecting to \");\n  Serial.println(ssid);\n  WiFi.begin(ssid, pass);\n\n  //turn on board LED on and off blink if connected\n  while (WiFi.status() != WL_CONNECTED) {\n    digitalWrite(LED_BUILTIN, LOW);\n    delay(10);\n    digitalWrite(LED_BUILTIN, HIGH);\n    delay(500);\n    Serial.print(\".\");\n  }\n  Serial.println(\"\");\n\n  Serial.println(\"WiFi connected\");\n  Serial.println(\"IP address: \");\n  Serial.println(WiFi.localIP());\n\n  Serial.println(\"Starting UDP\");\n  Udp.begin(localPort);\n  Serial.print(\"Local port: \");\n  Serial.println(localPort);\n\n\n  //onboard blue LED\n  pinMode(LED_BUILTIN, OUTPUT);\n  digitalWrite(LED_BUILTIN, HIGH);\n\n\n\n}\n\n//reads and dispatches the incoming message\nvoid loop() {\n  OSCMessage message;\n  int size;\n  //if our OSC data is greater than zero\n  if ( (size = Udp.parsePacket()) > 0)\n  {\n    while (size--)\n      message.fill(Udp.read());\n    if (!message.hasError()) {\n      //debug is it working?\n      Serial.println(\"working\");\n      //send the message to the 'routeOn' function\n      message.dispatch(\"/on\", routeOn);\n\n    }\n  }\n\n}\n\n//what we are doing with the OSC message\nvoid routeOn(OSCMessage &msg) {\n  if (msg.isInt(0)) {\n\n    LEDon = msg.getInt(0);\n    //send ON (1) message out to digitalPIn\n    digitalWrite(LED_BUILTIN, !LEDon);\n    //debugging print to console\n    Serial.print(\"/on: \");\n    Serial.println(\"ON\");\n\n  }\n\n  //otherwise it's a floating point\n  else if (msg.isFloat(0)) {\n    //if we receive a flot instead of an int\n    LEDon = msg.getFloat(0);\n    digitalWrite(LED_BUILTIN, !LEDon);\n    //debugging print to console\n    Serial.print(\"/on: \");\n    Serial.println(\"ON\");\n  }\n\n \n  }"
								}

							}
 ],
						"lines" : [  ]
					}
,
					"patching_rect" : [ 664.45947265625, 26.0, 131.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"tags" : ""
					}
,
					"text" : "p ArduinoRecieveCode"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-26",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 506.0, 26.0, 150.0, 47.0 ],
					"text" : "double click when locked to open up  Arduino code for sending or recieving"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-7",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 8,
							"minor" : 0,
							"revision" : 1,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "box",
						"rect" : [ 59.0, 103.0, 640.0, 480.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-2",
									"linecount" : 119,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 32.0, 19.0, 544.0, 1602.0 ],
									"text" : "/**************************************************************************/\n/**************************************************************************/\n/*SendCount++ function referenced from Sebastien Lexler example code*/\n/*Simplified and modified for teaching by Jen Sykes*/\n/* ESP8266 info */\n#include <ESP8266WiFi.h>\n#include <WiFiUdp.h>\n#include <OSCMessage.h>  /// https://github.com/CNMAT/OSC\n#include <OSCBundle.h>  /// https://github.com/CNMAT/OSC\n\n\n\nchar ssid[] = \"yournetworkname\";          // your network SSID (name)\nchar pass[] = \"yourpassword\";                    // your network password\n\nWiFiUDP Udp;                                // A UDP instance to let us send and receive packets over UDP\nconst IPAddress outIp(192, 168, 0, 111);     // remote IP of your computer\nconst unsigned int outPort = 9999;          // remote port to receive OSC\nconst unsigned int localPort = 8888;        // local port to listen for OSC packets (actually not used for sending)\n\nlong sendCount = 0;\nlong frameCount = 0;\nvoid sendBundleViaOSC();\nint data = 0;\n/**************************************************************************/\n\n\nvoid oscSetup() {\n  pinMode(0, OUTPUT);\n  digitalWrite(0, HIGH);\n  Serial.begin(115200);\n  // Connect to WiFi network\n  Serial.println();\n  Serial.println();\n  Serial.print(\"Connecting to \");\n  Serial.println(ssid);\n  WiFi.begin(ssid, pass);\n\n  while (WiFi.status() != WL_CONNECTED) {\n    digitalWrite(0, LOW);\n    delay(10);\n    digitalWrite(0, HIGH);\n    delay(500);\n    Serial.print(\".\");\n  }\n  Serial.println(\"\");\n\n  Serial.println(\"WiFi connected\");\n  Serial.println(\"IP address: \");\n  Serial.println(WiFi.localIP());\n\n  Serial.println(\"Starting UDP\");\n  Udp.begin(localPort);\n  Serial.print(\"Local port: \");\n  Serial.println(localPort);\n\n}\n\nvoid setup(void)\n{\n\n  Serial.begin(115200);\n  oscSetup();\n\n}\n\n\n/**************************************************************************/\n/*\n    Arduino loop function, called once 'setup' is complete (your own code\n    should go here)\n*/\n/**************************************************************************/\nvoid loop(void)\n{\n\n  frameCount++;\n\n  //send data every 2nd frame\n  if (frameCount < 2) {\n    //visual turn light on when sending\n    digitalWrite(0, LOW); //blue LED on\n  } else {\n    digitalWrite(0, HIGH);\n  }\n\n\n  if (frameCount > 500) {\n    frameCount = 0;\n  }\n  sendCount ++;\n  //if sendCount is over 1000 (1 second) send OSC info\n  if (sendCount > 1000)\n  {\n\n    sendViaOSC();//send messages\n\n    //sendBundleViaOSC()  //send bundle\n    Serial.println(\"sendingdata\");\n\n  }\n}\n\n\nvoid sendViaOSC() {\n  data++;\n  OSCMessage msg(\"/lightsensor\");\n  msg.add((int32_t)data);\n  //  msg.add(\"/d12\");\n  //  msg.add((int32_t)digitalRead(12));\n    msg.add(\"/string\");\n    msg.add(\"hello, osc.\");\n  Udp.beginPacket(outIp, outPort);\n  msg.send(Udp);\n  Udp.endPacket();\n  msg.empty();\n  sendCount = 0;\n}"
								}

							}
 ],
						"lines" : [  ]
					}
,
					"patching_rect" : [ 377.0, 26.0, 116.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"tags" : ""
					}
,
					"text" : "p ArduinoSendCode"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-23",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 189.784500122070312, 637.0, 146.0, 36.0 ],
					"text" : "See the OSC message printed here",
					"textcolor" : [ 0.50196099281311, 0.50196099281311, 0.50196099281311, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"bgcolor" : [ 0.52156862745098, 0.768627450980392, 0.772549019607843, 0.85 ],
					"fontsize" : 16.0,
					"id" : "obj-19",
					"linecount" : 6,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 32.5, 394.0, 328.0, 114.0 ],
					"text" : "If you want to edit any information (ports, ip addresses etc) you must unlock the patch and double click inside a message. \n\nTo run the patch make sure it is locked and click the message associated with the port. "
				}

			}
, 			{
				"box" : 				{
					"bgcolor" : [ 0.772549019607843, 0.564705882352941, 0.564705882352941, 0.86 ],
					"fontsize" : 16.0,
					"id" : "obj-16",
					"linecount" : 6,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 25.0, 26.0, 269.0, 114.0 ],
					"text" : "SENDING OUT MESSAGES\n\nSelect the port you want to send to. Make sure the ip address is either local (127.0.01) or the ip address of the device you are sending to. "
				}

			}
, 			{
				"box" : 				{
					"bgcolor" : [ 0.925490196078431, 0.854901960784314, 0.419607843137255, 0.93 ],
					"fontsize" : 16.0,
					"id" : "obj-14",
					"linecount" : 7,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 431.0, 394.0, 443.0, 132.0 ],
					"text" : "RECIEVING MESSAGES\n\nclick the port 9999 message box to listen to message on this port. \n\nMake sure your device sending the information is sending on the same network as this laptop to the laptop's IP address"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-5",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 431.0, 570.0, 63.0, 23.0 ],
					"text" : "port 8000"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-2",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 158.0, 279.5, 132.0, 21.0 ],
					"text" : "set alternate port ",
					"textcolor" : [ 0.50196099281311, 0.50196099281311, 0.50196099281311, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-1",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 93.0, 279.5, 63.0, 23.0 ],
					"text" : "port 8888"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-13",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 274.25, 675.0, 155.0, 22.0 ],
					"text" : "/ping"
				}

			}
, 			{
				"box" : 				{
					"border" : 0,
					"filename" : "helpargs.js",
					"id" : "obj-31",
					"ignoreclick" : 1,
					"jsarguments" : [ "udpreceive" ],
					"maxclass" : "jsui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 596.0, 609.0, 199.459503173828125, 54.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-3",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 377.0, 155.0, 20.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-6",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 444.75, 243.0, 154.0, 23.0 ],
					"text" : "/giveme some please 44"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"format" : 6,
					"id" : "obj-8",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 412.75, 209.0, 54.0, 23.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-9",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 395.75, 180.0, 53.0, 23.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-10",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 490.0, 671.0, 189.0, 23.0 ],
					"text" : "print receivedmess @popup 1"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-11",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 565.0, 549.0, 146.0, 36.0 ],
					"text" : "set local port to listen for messages on",
					"textcolor" : [ 0.50196099281311, 0.50196099281311, 0.50196099281311, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-12",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 502.0, 569.0, 63.0, 23.0 ],
					"text" : "port 9999"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-17",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 148.5, 211.5, 132.0, 36.0 ],
					"text" : "set port to send messages to at host",
					"textcolor" : [ 0.50196099281311, 0.50196099281311, 0.50196099281311, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-18",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 25.0, 145.0, 90.0, 23.0 ],
					"text" : "host localhost"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-20",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 65.0, 211.5, 67.0, 23.0 ],
					"text" : "port 7400"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-21",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 50.0, 170.0, 93.0, 23.0 ],
					"text" : "host 127.0.0.1"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-22",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 490.0, 609.0, 105.0, 23.0 ],
					"text" : "udpreceive 9999"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-24",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 50.0, 338.0, 149.0, 23.0 ],
					"text" : "udpsend 127.0.0.1 8888"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-25",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 143.0, 145.0, 143.0, 36.0 ],
					"text" : "set the host by ip address or hostname",
					"textcolor" : [ 0.50196099281311, 0.50196099281311, 0.50196099281311, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-28",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 473.0, 150.0, 206.0, 50.0 ],
					"text" : "Max messages are serialized and sent over the network as OSC compatible UDP packets.",
					"textcolor" : [ 0.50196099281311, 0.50196099281311, 0.50196099281311, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"border" : 0,
					"filename" : "helpargs.js",
					"id" : "obj-4",
					"ignoreclick" : 1,
					"jsarguments" : [ "udpsend" ],
					"maxclass" : "jsui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 209.0, 335.0, 107.569000244140625, 54.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-24", 0 ],
					"source" : [ "obj-1", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-22", 0 ],
					"midpoints" : [ 511.5, 600.0, 499.5, 600.0 ],
					"source" : [ "obj-12", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-24", 0 ],
					"midpoints" : [ 34.5, 274.0, 59.5, 274.0 ],
					"source" : [ "obj-18", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-24", 0 ],
					"midpoints" : [ 74.5, 264.0, 59.5, 264.0 ],
					"source" : [ "obj-20", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-24", 0 ],
					"source" : [ "obj-21", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-10", 0 ],
					"order" : 0,
					"source" : [ "obj-22", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-13", 1 ],
					"midpoints" : [ 499.5, 658.0, 419.75, 658.0 ],
					"order" : 1,
					"source" : [ "obj-22", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-24", 0 ],
					"midpoints" : [ 386.5, 282.0, 59.5, 282.0 ],
					"source" : [ "obj-3", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-22", 0 ],
					"source" : [ "obj-5", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-24", 0 ],
					"midpoints" : [ 454.25, 282.0, 59.5, 282.0 ],
					"source" : [ "obj-6", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-24", 0 ],
					"midpoints" : [ 422.25, 282.5, 59.5, 282.5 ],
					"source" : [ "obj-8", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-24", 0 ],
					"midpoints" : [ 405.25, 282.0, 59.5, 282.0 ],
					"source" : [ "obj-9", 0 ]
				}

			}
 ],
		"dependency_cache" : [ 			{
				"name" : "helpargs.js",
				"bootpath" : "C74:/help/resources",
				"type" : "TEXT",
				"implicit" : 1
			}
 ],
		"autosave" : 0
	}

}
