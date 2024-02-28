import java.util.concurrent.locks.ReentrantLock;

class Bank{

    private static class Account{
        private int balance;
        Account (int balance) {this.balance = balance;}
        int balance(){return balance;}
        boolean deposit(int value){
            balance += value;
            return true;
        }
    }

// Our single account, for now
private Account savings = new Account(0);

ReentrantLock l = new ReentrantLock();


//Account balance
public int balance(){
    return savings.balance();
}

//Deposit
boolean deposit (int value){
    l.lock();
    try{
        return savings.deposit(value);
    }finally {  //the rock has comeback
        l.unlock();
    }
}

}

class Depositor implements Runnable{
    final long I;
    final long V;
    final Bank b;

    Depositor(Long I, int V, Bank b){
        this.I = I;
        this.V = V;
        this.b = b;
    }

        public void run(){
            for (long i = 0; i < I; i++){
                b.deposit(V);
            }
        }

}



class Main{
    public static void main(String[] args)throws InterruptedException{
        final int N = Integer.parseInt(args[0]);
        final int I = Integer.parseInt(args[1]);
        final int V = Integer.parseInt(args[2]);

        Bank b = new Bank();
        Thread[] a = new Thread[N];
         for(int i = 0; i < N; i++){
            a[i] = new Thread(new Depositor(I, V, b));
        }

        for(int i = 0; i < N; i++){
            a[i].start();
        }

        for(int i = 0; i < N; i++){
            a[i].join();
        }


        System.out.println("fim");
    }
}