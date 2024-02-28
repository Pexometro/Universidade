import socket
import os
import sys
import threading
import time
import queue

class FSNode:
    def __init__(self, nodeName, sharedFolder, host='10.4.4.1', port=9090, blockSize=1024): #concertar
        self.nodeName = nodeName
        self.host = host
        self.port = port
        self.sharedFolder = sharedFolder
        self.blockSize = blockSize
        self.trackerSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.trackerSocket.connect((self.host, self.port))
        self.udpSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.is_running = True

        self.udpSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        #self.udpSocket.bind((test_bind(), 0)) #concertar 
        self.udpPort = self.udpSocket.getsockname()[1]

    def numBlocks(self, size):
        num = size // self.blockSize
        if size % self.blockSize != 0:
            num += 1
        return num

    def registerFiles(self):
        try:
            files = os.listdir(self.sharedFolder)
            fileInfoList = []

            for fileName in files:
                filePath = os.path.join(self.sharedFolder, fileName)
                fileSize = os.path.getsize(filePath)
                numBlocks = self.numBlocks(fileSize)

                if "_block" in fileName:
                    block = fileName.split("_block")
                    fileInfo = f"{block[0]}:{block[1]}:block"
                else:
                    fileInfo = f"{fileName}:{fileSize}:{numBlocks}"
                fileInfoList.append(fileInfo)

            message = f"REGISTER {self.nodeName} {';'.join(fileInfoList)}"
            self.trackerSocket.sendall(message.ljust(1024).encode())

        except (ConnectionError, FileNotFoundError, PermissionError) as e:
            print(f"Error: {e}")

    def updateNode(self):
        self.registerFiles()
    
    def processCommand(self, command):
        try:
            command = command.upper().ljust(1024)
            self.trackerSocket.sendall(command.encode('utf-8'))
            
            if command.startswith("LISTFILES"):
                response = self.trackerSocket.recv(4096).decode('utf-8').rstrip()
                print(response)
            else:
                data = self.trackerSocket.recv(1024).decode('utf-8').rstrip()
                print(data)

        except ConnectionError as e:
            print(f"Erro ao conectar-se ao FS_Tracker: {e}")

    def sendFile(self, filePath, serverAddress):
        try:
            with open(filePath, 'rb') as file:
                while True:
                    block = file.read(1024)
                    if not block:
                        break
                    self.udpSocket.sendto(block, serverAddress)

                self.udpSocket.sendto(b'', serverAddress)
                print(f'File sent to {serverAddress}.')

        except Exception as e:
            print(f"Error: {e}")

    def exitNode(self):
        try:
            self.processCommand(f"EXIT {self.nodeName}")
            time.sleep(1)  # Espera por 1 segundo para dar tempo ao servidor processar a saída
            self.close()
            self.is_running = False  # Atualiza a variável para sair do loop
        except ConnectionError as e:
            print(f"Error while exiting node: {e}")

    def requestFile(self, fileName):
        self.processCommand(f"LOCATE {fileName}")

    def close(self):
        try:
            self.processCommand(f"close {self.nodeName}")
            time.sleep(1)  # Espera por 1 segundo para dar tempo ao servidor processar o encerramento
            self.trackerSocket.close()
            self.trackerSocket = None  # Define o socket como None após fechar
        finally:
            pass

    def __str__(self):
        return f"FSNode '{self.nodeName}' {self.host}:{self.port} folder: '{self.sharedFolder}')"

def test_bind():
    ips_to_test = ["10.1.1.1", "10.1.1.2", "10.2.2.1", "10.2.2.2"]

    for ip in ips_to_test:
        try:
            udp_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            udp_socket.bind((ip, 0))  
            print(f"Bind bem-sucedido em {ip}")
            udp_socket.close()
            break
        except Exception as e:
            print(f"Erro ao fazer bind em {ip}: {e}")

def connectToTracker(tracker_host, tracker_port):
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect((tracker_host, tracker_port))
    return client_socket

def handleGetCommand(command, client_socket):
    try:
        if command.startswith("GET"):
            client_socket.send(command.encode('utf-8'))
            response = client_socket.recv(1024)
            print(response.decode('utf-8'))
        elif command.startswith("Closing connection"):
            print("Server closed the connection.")
            client_socket.close()  # Fecha o socket do cliente
        else:
            print("Unrecognized command.")
    except OSError as e:
        print(f"Error executing GET command: {e}")


def handleListFilesCommand(fs_node):
    try:
        files = os.listdir(fs_node.sharedFolder)
        file_list = "\n".join(files)
        print(f"Files in shared folder:\n{file_list}")
    except Exception as e:
        print(f"Error listing files: {e}")

def closeConnection(self):
        try:
            self.sock.sendall("EXIT".encode('utf-8'))
            self.sock.close()
            print("Connection closed.")
        except ConnectionError as e:
            print(f"Error closing connection: {e}")
            
def command_input(fs_node):
    while True:
        command = input("Enter a command (e.g., GET file1): ")
        command_div = command.split()

        if command_div[0] == "EXIT":
            fs_node.exitNode()
            break  # Sai do loop se o comando for "EXIT"

        if command_div[0] == "GET":
            handleGetCommand(command, fs_node.trackerSocket)
        elif command_div[0] == "REGISTER":
            fs_node.registerFiles()
        elif command_div[0] == "LISTFILES":
            fs_node.processCommand(f"LISTFILES {command_div[1]}")  
        else:
            fs_node.processCommand(command)
            
def execute_commands(fs_node):
    while fs_node.is_running:
        command = input("Enter a command (e.g., GET file1): ")
        command_div = command.split()

        if command_div[0] == "EXIT":
            fs_node.exitNode()
            break  # Sai do loop se o comando for "EXIT"

        if command_div[0] == "GET":
            handleGetCommand(command, fs_node.trackerSocket)
        elif command_div[0] == "REGISTER":
            fs_node.registerFiles()
        elif command_div[0] == "LISTFILES":
            handleListFilesCommand(fs_node)
        else:
            fs_node.processCommand(command)

        # Aguarda um pouco antes de aceitar novos comandos
        time.sleep(0.1)
            
def main():
    if len(sys.argv) < 4:
        print("Usage: python fs_node.py <SHARED_FOLDER> <TRACKER_HOST> <TRACKER_PORT>")
        sys.exit(1)

    ip_permitidos = ['10.4.4.1','10.4.4.2','10.3.3.1','10.3.3.2']
    
    shared_folder = os.path.abspath(sys.argv[1])
    TRACKER_HOST = sys.argv[2]
    TRACKER_PORT = int(sys.argv[3])
    if TRACKER_HOST in ip_permitidos:
        print("IP encontrado!")
    else:
        print("IP não encontrado!")
        exit(1)
    
    test_bind()
    fs_node = FSNode("Node1", shared_folder, TRACKER_HOST, TRACKER_PORT)
    
    command_queue = queue.Queue()
    command_thread = threading.Thread(target=command_input, args=(fs_node,))
    command_thread.daemon = True
    command_thread.start()
    
    try:
        periodic_thread = threading.Thread(target=fs_node.updateNode)
        periodic_thread.daemon = True
        periodic_thread.start()

        while fs_node.is_running:
            command = input("Enter a command (e.g., GET file1): ")
            command_div = command.split()

            if command_div[0] == "EXIT":
                fs_node.exitNode()
                break  # Sai do loop se o comando for "EXIT"

            if command_div[0] == "GET":
                handleGetCommand(command, fs_node.trackerSocket)
            elif command_div[0] == "REGISTER":
                fs_node.registerFiles()
            elif command_div[0] == "LISTFILES":  
                handleListFilesCommand(fs_node)
            else:
                fs_node.processCommand(command)
            pass

    finally:
        fs_node.close()

if __name__ == "__main__":
    main()
