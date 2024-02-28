class Increment implements Runnable{
    public void run(){
        final long I = 100;

        for (long i = 0; i < I;i++){
            System.out.println(i);
        }
    }
}


class Main{
    public static void main(String[] args)throws InterruptedException{
        final int N = Integer.parseInt(args[0]);

        Thread[] a = new Thread[N];
         for(int i = 0; i < N; i++){
            a[i] = new Thread(new Increment());
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