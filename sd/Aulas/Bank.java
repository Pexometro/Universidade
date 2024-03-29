import java.util.concurrent.locks.ReentrantLock;

public class Bank {

    private static class Account {
        private int balance;
        Account(int balance) { this.balance = balance; }
        int balance() { return balance; }
        boolean deposit(int value) {
            balance += value;
            return true;
        }
        boolean withdraw(int value) {
            if (value > balance)
                return false;
            balance -= value;
            return true;
        }
    }

    // Bank slots and vector of accounts
    private int slots;
    private Account[] av; 
    private final ReentrantLock l = new ReentrantLock();

    public Bank(int n) {
        slots=n;
        av=new Account[slots];
        for (int i=0; i<slots; i++) av[i]=new Account(0);
    }

    // Account balance
    public int balance(int id) {
        if (id < 0 || id >= slots)
            return 0;
        l.lock();
        try{
            return av[id].balance();
        }finally{
            l.unlock();
        }
    }

    // Deposit
    public boolean deposit(int id, int value) {
        if (id < 0 || id >= slots)
            return false;
            l.lock();
            try{
               return av[id].deposit(value);
            }
            finally{
                l.unlock();
            }
    }

    // Withdraw; fails if no such account or insufficient balance
    public boolean withdraw(int id, int value) {
        if (id < 0 || id >= slots)
            return false;
        l.lock();
        try{
          return av[id].withdraw(value);
        } finally{
            l.unlock();
        }
    }

    public boolean transfer (int from, int to, int value){
        if (from < 0 || from >= slots || to < 0 || to >= slots)
            return false;
        return withdraw(from, value) && deposit(to, value);
    }

    public static void main(String[] args) throws InterruptedException {
        final int N=10;

        Bank b = new Bank(N);

        for (int i=0; i<N; i++) 
            b.deposit(i,1000);

        System.out.println(b.totalBalance());

        Thread t1 = new Thread(new Mover(b,10)); 
        Thread t2 = new Thread(new Mover(b,10));

        t1.start(); t2.start(); t1.join(); t2.join();

        System.out.println(b.totalBalance());
  }

}
