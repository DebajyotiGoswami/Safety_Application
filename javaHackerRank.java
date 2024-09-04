import java.util.Scanner;
import java.io.*;
import java.math.*;
import java.security.*;
import java.text.*;
import java.util.*;
import java.util.concurrent.*;
import java.util.regex.*;

class Test {
    // public static void main(String[] args) {
    //     System.out.println("Hello, World.");
    //     System.out.println("Hello, Java.");
    // }

    // public static void main(String[] args){
    //     Scanner scanner= new Scanner(System.in);
    //     int i= scanner.nextInt();
    //     double d= scanner.nextDouble();
    //     scanner.nextLine();
    //     String s= scanner.nextLine();

    //     System.out.println("String: " + s);
    //     System.out.println("Double: " + d);
    //     System.out.println("Int: " + i);
        
    //     scanner.close();
    // }

    // public static void main(String[] args) {
    //     Scanner sc=new Scanner(System.in);
    //     System.out.println("================================");
    //     for(int i=0;i<3;i++){
    //         String s1=sc.next();
    //         int x=sc.nextInt();
    //         //Complete this line
    //         System.out.printf("%-15s%03d%n", s1, x);
    //     }
    //     System.out.println("================================");
    // }

    // public static void main(String[] args) throws IOException {
    //     BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));

    //     int N = Integer.parseInt(bufferedReader.readLine().trim());
    //     for(int i= 1; i<= 10; i++){
    //         String output= Integer.toString(N)+ " x "+ Integer.toString(i)+ " = "+ Integer.toString(N* i);
    //         System.out.println(output);
    //     }

    //     bufferedReader.close();
    // }

    // public static void main(String []argh){
    //     Scanner in = new Scanner(System.in);
    //     int t=in.nextInt();
    //     for(int i=0;i<t;i++){
    //         int a = in.nextInt();
    //         int b = in.nextInt();
    //         int n = in.nextInt();            
        
    //         int valueSum= a;
    //         String output= "";
    //         for(int exponent= 0; exponent< n; exponent++){
    //             valueSum+= Math.pow(2, exponent)* b;
    //             // System.out.println(valueSum);
    //             output+= Integer.toString(valueSum)+ " ";
    //         }
    //         System.out.println(output);
    //     }
    //     in.close();
    // }

    public static void main(String[] argh) {
        Scanner sc = new Scanner(System.in);
        int t = sc.nextInt();

        double byteValue= Math.pow(2, 7);
        double shortValue= Math.pow(2, 15);
        double intValue= Math.pow(2, 31);
        double longValue= Math.pow(2, 63);
        
        for (int i = 0; i < t; i++) {
            try {long x = sc.nextLong();
                System.out.println(x + " can be fitted in:");
                if (x >= 0- byteValue && x <= byteValue- 1){
                    //x is within the range of unsigned byte
                    System.out.println("* byte");
                    System.out.println("* short");
                    System.out.println("* int");
                    System.out.println("* long");
                }
                else if(x>= 0- shortValue && x<= shortValue- 1){
                    //x is within the range of unsigned short
                    System.out.println("* short");
                    System.out.println("* int");
                    System.out.println("* long");
                }
                else if(x>= 0- intValue && x<= intValue- 1){
                    //x is within the range of unsigned int
                    System.out.println("* int");
                    System.out.println("* long");
                }
                else if(x>= 0- longValue && x<= longValue- 1){
                    //x is within the range of unsigned byte
                    System.out.println("* long");
                }
            } catch (Exception e) {
                System.out.println(sc.next() + " can't be fitted anywhere.");
            }

        }
    }
}