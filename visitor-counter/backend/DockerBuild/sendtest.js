import mqtt from "mqtt";

const mqttUrl = "mqtt://localhost:1883";
const client = mqtt.connect(mqttUrl);

client.on("connect", () => {
  console.log("Conectado ao broker!");

  const msg = {
    sensorId: "barreira-01",
    type: "proximity",
    detected: true,
    value: 1,
    timestamp: new Date().toISOString()
  };

  client.publish("sensors/barreira-01/barreira", JSON.stringify(msg), {}, () => {
    console.log("Mensagem enviada!");
    client.end();
  });
});
