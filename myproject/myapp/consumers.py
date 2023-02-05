from channels.generic.websocket import AsyncWebsocketConsumer
import json

class NotificationConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        # This method is called when the websocket is handshaking.
        # We can use it to do any setup we need for the consumer.
        await self.accept()

    async def disconnect(self, close_code):
        # This method is called when the WebSocket closes for any reason.
        # We can use it to do any cleanup we need before the consumer is disconnected.
        # Any exception raised here will not be propagated.
        pass

    async def receive(self, text_data):
        # This method is called when the server receives a message from the websocket.
        text_data_json = json.loads(text_data)
        message = text_data_json['message']

        # Send a message back to the websocket
        await self.send(text_data=json.dumps({
            'message': message
        }))

