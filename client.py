con="ws://msivaji.in:4000/socket/websocket"
# import websocket
# import json
# def on_message(ws, message):
#     print(f"Received message: {message}")

# def on_error(ws, error):
#     print(f"Received error: {error}")

# def on_close(ws):
#     print("Connection closed")

# if __name__ == "__main__":
#     websocket.enableTrace(True)
#     # ws = websocket.WebSocketApp("ws://msivaji.in:4000/socket/websocket",
#     #                           on_message = on_message,
#     #                           on_error = on_error,
#     #                           on_close = on_close)
#     # ws.run_forever()
#     ws = websocket.create_connection("ws://msivaji.in:4000/socket/websocket")
#     ws.recv()
#     print("hii")
#     #"event_id" => 6, "sender" => "Server", "value" => %{"A" => 15}
#     message = {"topic": "robot:status", "event": "event_msg", "payload": {"event_id": 6, "sender": "Client", "value": {"A": 15}}}
#     ws.send(json.dumps(message))





import phxsocket
socket = phxsocket.Client(con, {"options": "something"})
if socket.connect(): # blocking, raises exception on failure
  channel = socket.channel("robot:status", {"more options": "something else"})
  resp = channel.join() # also blocking, raises exception on failure






# def do_something(payload):
#       thing = payload["thing"]

# channel.on("eventname", do_something)

channel.push("event_msg", {"event_id": 6, "sender": "Client", "value": {"A": 15}})
