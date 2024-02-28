import sys
import socket
import threading
import json
import os

class FSTracker:
    def __init__(self, host='10.4.4.2', port=9090):
        self.host = host
        self.port = port
        self.nodeStorage = {}
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.bind((self.host, self.port))
        self.socket.listen()
        
    def start(self):
        print(f"Tracker connected on {self.host}:{self.port}...")
        while True:
            conn, addr = self.socket.accept()
            print(f"Connection established with {addr}")
            threading.Thread(target=self.handleConn, args=(conn, addr)).start()

    def handleConn(self, conn, addr):
        while True:
            data = conn.recv(1024)

            if not data:
                break
            
            cmd = data.decode().rstrip().split()
            print(f"Received from {addr}: {cmd}")

            if cmd[0] == 'EXIT':
                response = "Exiting node..."
                conn.send(response.encode('utf-8'))
                node_name = cmd[1]
                if node_name in self.nodeStorage:
                    del self.nodeStorage[node_name]
                conn.shutdown(socket.SHUT_RDWR)
                conn.close()
                break
            elif cmd[0] == "listfiles":
                self.listFiles(conn)

    def listFiles(self, conn):
        try:
            files = os.listdir('.')  
            file_list = "\n".join(files)
            conn.send(file_list.encode('utf-8'))
        except Exception as e:
            conn.send(f"Error listing files: {e}".encode('utf-8'))


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python FS_Tracker.py <HOST_IP>")
        sys.exit(1)

    HOST_IP = sys.argv[1]
    tracker = FSTracker(host=HOST_IP)
    tracker.start()
