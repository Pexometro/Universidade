import javax.sound.sampled.SourceDataLine;

class MyThread extends Thread{
    public void run(){
        System.out.println("No thread");
    }
}

class MyRunnable implements Runnable{
    public void run(){
        for (long l = 0; l < 1L << 32; i++){
            ;
    }
     System.out.println("");
}
}

class Main {
    public static void main(String[] args){
        MyThread t = new MyThread();
        // t.run() <-- nunca fazer!!!
        t1.start();
        System.out.println("No main");
    }
}