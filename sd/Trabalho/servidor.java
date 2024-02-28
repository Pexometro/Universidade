import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashMap;
import java.util.Map;

public class Servidor {

    private static Map<String, String> users = new HashMap<>(); // Mapeamento de usuários e senhas
    private static int tarefasPendentes = 0; // Variável para controlar o número de tarefas pendentes
    private static int memoriaDisponivel = 2048; // Quantidade de memória disponível

    public static void main(String[] args) {
        users.put("usuario1", "senha1");
        users.put("usuario2", "senha2");

        try {
            ServerSocket serverSocket = new ServerSocket(12345); // Porta do servidor

            while (true) {
                Socket clientSocket = serverSocket.accept(); // Aceita conexão com cliente
                Thread clientThread = new Thread(new ClientHandler(clientSocket));
                clientThread.start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static class ClientHandler implements Runnable {
        private Socket clientSocket;

        ClientHandler(Socket socket) {
            this.clientSocket = socket;
        }

        public void run() {
            try {
                BufferedReader in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
                PrintWriter out = new PrintWriter(clientSocket.getOutputStream(), true);

                String userInput;
                while ((userInput = in.readLine()) != null) {
                    // Lógica de autenticação
                    if (userInput.equals("login")) {
                        String username = in.readLine();
                        String password = in.readLine();
                        if (authenticate(username, password)) {
                            out.println("Login bem-sucedido!");
                            // Lógica para permitir envio de tarefas
                            // Lógica para consulta de estado
                        } else {
                            out.println("Falha na autenticação. Tente novamente.");
                        }
                    } else if (userInput.equals("enviarTarefa")) {
                        String codigoTarefa = in.readLine();
                        int memoriaNecessaria = Integer.parseInt(in.readLine());
                        // Processamento da tarefa e alocação de recursos
                        out.println("Tarefa recebida e em processamento.");
                    } else if (userInput.equals("consultaEstado")) {
                        // Lógica para consulta de estado
                        int tarefasPendentes = getTarefasPendentes();
                        int memoriaDisponivel = getMemoriaDisponivel();

                        out.println("Tarefas pendentes: " + tarefasPendentes + ", Memória disponível: " + memoriaDisponivel);
                    }
                    // Lógica para outras operações de serviço
                }

                clientSocket.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        private boolean authenticate(String username, String password) {
            return users.containsKey(username) && users.get(username).equals(password);
        }

        private synchronized int getTarefasPendentes() {
            return tarefasPendentes;
        }

        private synchronized int getMemoriaDisponivel() {
            return memoriaDisponivel;
        }
    }
}

