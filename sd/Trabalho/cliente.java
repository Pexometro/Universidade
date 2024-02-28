import java.io.*;
import java.net.Socket;

public class Cliente {

    public static void main(String[] args) {
        try {
            Socket socket = new Socket("localhost", 12345); // Conexão com o servidor

            BufferedReader userInput = new BufferedReader(new InputStreamReader(System.in));
            PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));

            System.out.println("Digite 'login' para entrar:");
            String command = userInput.readLine();

            if (command.equals("login")) {
                out.println("login");
                System.out.println("Digite seu nome de usuário:");
                String username = userInput.readLine();
                out.println(username);
                System.out.println("Digite sua senha:");
                String password = userInput.readLine();
                out.println(password);

                String response = in.readLine();
                System.out.println("Servidor: " + response);

                if (response.equals("Login bem-sucedido!")) {
                    while (true) {
                        System.out.println("Digite 'enviarTarefa' para enviar uma tarefa ou 'consultaEstado' para verificar o estado:");
                        command = userInput.readLine();

                        if (command.equals("enviarTarefa")) {
                            out.println("enviarTarefa");
                            System.out.println("Digite o código da tarefa:");
                            String codigoTarefa = userInput.readLine();
                            out.println(codigoTarefa);
                            System.out.println("Digite a quantidade de memória necessária:");
                            String memoriaNecessaria = userInput.readLine();
                            out.println(memoriaNecessaria);

                            String taskResponse = in.readLine();
                            System.out.println("Servidor: " + taskResponse);
                        } else if (command.equals("consultaEstado")) {
                            out.println("consultaEstado");

                            String estadoResponse = in.readLine();
                            System.out.println("Estado do Servidor: " + estadoResponse);
                        } else {
                            System.out.println("Comando inválido!");
                        }
                    }
                }
            }

            socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
