<%-- 
    Document   : index
    Created on : 16 jul. 2024, 01:03:46
    Author     : mych7
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" 
        import="java.sql.Connection, java.util.ArrayList, java.util.List, java.sql.ResultSet, java.sql.ResultSetMetaData, java.sql.SQLException, java.sql.Statement, java.util.LinkedList, java.util.concurrent.ForkJoinPool, java.util.concurrent.RecursiveTask, java.util.logging.Level, java.util.logging.Logger, javax.swing.table.DefaultTableModel"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
                                    
        <%
            
            class TreeNode {
    String root;
    List<Object[]> leaves;

    public TreeNode(String root) {
        this.root = root;
        this.leaves = new ArrayList<>();
    }

    public void addLeaf(Object[] leaf) {
        this.leaves.add(leaf);
    }

    public String getRoot() {
        return root;
    }

    public List<Object[]> getLeaves() {
        return leaves;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Root: ").append(root).append("\n");
        sb.append("Leaves:\n");
        for (Object[] leaf : leaves) {
            sb.append("  ");
            for (Object obj : leaf) {
                sb.append(obj).append(" ");
            }
            sb.append("\n");
        }
        return sb.toString();
    }
}
            
            class calculocons {
    String url = "jdbc:sqlite:C:\\Users\\mych7\\Downloads\\moises\\datos.db";
Connection connect;

public void main(String[] args) {
        pruebas(0,0);
    }
            
          private void pruebas(int modo, int id) {
        
        // Adaptación de tabla hash
        LinkedList<Object[]> myList = new LinkedList<>();
        
        String sql;
        
            sql = "SELECT * from VWgeneral2";

        Statement statemen;
        
        
    try {
        statemen = connect.createStatement();
        ResultSet resultSet = statemen.executeQuery(sql);
        
        ResultSetMetaData metaData = resultSet.getMetaData();
int columnCount = metaData.getColumnCount();
int c = 0;

    while (resultSet.next()) {
        Object[] c1 = new Object[9];
        for (int i = 1; i <= columnCount; i++) {
            Object value = resultSet.getObject(i);
            c1[i-1] = value;
            //System.out.println(value);
            //System.out.print(value + "\t");

        }


        myList.add(c1);
    } 
            
        // Inicio del tiempo de ejecución
        long inicio = System.nanoTime();

        // Ordenar la lista usando MergeSort concurrente
        ForkJoinPool pool = new ForkJoinPool();
        myList = pool.invoke(new MergeSortTask(myList));
        
        // Ordenar la lista usando MergeSort secuencial
        //myList = mergeSort(myList);

        // Fin del tiempo de ejecución
        long fin = System.nanoTime();

        // Cálculo del tiempo transcurrido en nanosegundos
        long tiempoTranscurrido = fin - inicio;

        System.out.println("Mergesort\nTiempo de ejecución: " + tiempoTranscurrido + " ns");

        
        
        if(modo==1){
            buscar(id,myList);
        }else{
            
            // Crear el árbol con la raíz "Root Node"
            TreeNode tree = new TreeNode("Usuario");
            
            for (Object[] tuple : myList) {
                //DefaultTableModel model = (DefaultTableModel) tblCalculo.getModel();
                //model.addRow(tuple);
                tree.addLeaf(tuple);
            }
            

        }
            // Imprimir las tuplas
        
        
       
        
        
        
        
        
        
    } catch (SQLException ex) {
        
    }
        
    }

    private void tabla() {
         
   }
    
    public  LinkedList<Object[]> quickSort(LinkedList<Object[]> list, int low, int high) {
        if (low < high) {
            int pi = partition(list, low, high);
            quickSort(list, low, pi - 1);
            quickSort(list, pi + 1, high);
        }
        
        return list;
    }

    int partition(LinkedList<Object[]> list, int low, int high) {
        Object pivot = list.get(high)[0]; // pivote es el elemento 0 de la última tupla
        int i = low - 1;
        for (int j = low; j < high; j++) {
            if ((int) list.get(j)[0] < (int) pivot) { // cambiar > a < para ordenar de menor a mayor
                i++;
                swap(list, i, j);
            }
        }
        swap(list, i + 1, high);
        return i + 1;
    }

        void swap(LinkedList<Object[]> list, int i, int j) {
        Object[] temp = list.get(i);
        list.set(i, list.get(j));
        list.set(j, temp);
    }

    private void buscar(int id, LinkedList<Object[]> myList) {
        
        // Inicio del tiempo de ejecución
        long inicio = System.nanoTime();
        
        System.out.println("inicia buscar con id "+id);
        
            int position = ternarySearch(myList, id);

        // Mostrar el resultado
        if (position != -1) {
            System.out.println("El id " + id + " se encuentra en la posición " + position + " de la LinkedList.");
        } else {
            System.out.println("El id " + id + " no se encuentra en la LinkedList.");
        }
        
        // Fin del tiempo de ejecución
        long fin = System.nanoTime();

        // Cálculo del tiempo transcurrido en nanosegundos
        long tiempoTranscurrido = fin - inicio;

        System.out.println("Busqueda ternaria\nTiempo de ejecución: " + tiempoTranscurrido + " ns");

    }
    
    // Método de búsqueda ternaria
    int ternarySearch(LinkedList<Object[]> list, int targetId) {
        return ternarySearch(list, targetId, 0, list.size() - 1);
    }

        int ternarySearch(LinkedList<Object[]> list, int targetId, int left, int right) {
        if (right >= left) {
            int mid1 = left + (right - left) / 3;
            int mid2 = right - (right - left) / 3;

            int mid1Id = (int) list.get(mid1)[0];
            int mid2Id = (int) list.get(mid2)[0];

            if (mid1Id == targetId) {
                return mid1; // Id encontrado en mid1
            }
            if (mid2Id == targetId) {
                return mid2; // Id encontrado en mid2
            }

            if (targetId < mid1Id) {
                return ternarySearch(list, targetId, left, mid1 - 1);
            } else if (targetId > mid2Id) {
                return ternarySearch(list, targetId, mid2 + 1, right);
            } else {
                return ternarySearch(list, targetId, mid1 + 1, mid2 - 1);
            }
        }

        return -1; // Id no encontrado
    }
    
        LinkedList<Object[]> mergeSort(LinkedList<Object[]> list) {
        if (list.size() <= 1) {
            return list;
        }

        int mid = list.size() / 2;
        LinkedList<Object[]> leftList = new LinkedList<>();
        LinkedList<Object[]> rightList = new LinkedList<>();

        int count = 0;
        for (Object[] tuple : list) {
            if (count < mid) {
                leftList.add(tuple);
            } else {
                rightList.add(tuple);
            }
            count++;
        }

        leftList = mergeSort(leftList);
        rightList = mergeSort(rightList);

        return merge(leftList, rightList);
    }

        LinkedList<Object[]> merge(LinkedList<Object[]> left, LinkedList<Object[]> right) {
        LinkedList<Object[]> mergedList = new LinkedList<>();

        while (!left.isEmpty() && !right.isEmpty()) {
            if ((int) left.peek()[0] <= (int) right.peek()[0]) { // Ordenar de menor a mayor
                mergedList.add(left.poll());
            } else {
                mergedList.add(right.poll());
            }
        }

        while (!left.isEmpty()) {
            mergedList.add(left.poll());
        }

        while (!right.isEmpty()) {
            mergedList.add(right.poll());
        }

        return mergedList;
    }  
            
        
        class MergeSortTask extends RecursiveTask<LinkedList<Object[]>> {
        private LinkedList<Object[]> list;

        MergeSortTask(LinkedList<Object[]> list) {
            this.list = list;
        }

        @Override
        protected LinkedList<Object[]> compute() {
            if (list.size() <= 1) {
                return list;
            }

            int mid = list.size() / 2;
            LinkedList<Object[]> leftList = new LinkedList<>();
            LinkedList<Object[]> rightList = new LinkedList<>();

            int count = 0;
            for (Object[] tuple : list) {
                if (count < mid) {
                    leftList.add(tuple);
                } else {
                    rightList.add(tuple);
                }
                count++;
            }

            MergeSortTask leftTask = new MergeSortTask(leftList);
            MergeSortTask rightTask = new MergeSortTask(rightList);

            leftTask.fork();
            rightList = rightTask.compute();
            leftList = leftTask.join();

            return merge(leftList, rightList);
        }

        private LinkedList<Object[]> merge(LinkedList<Object[]> left, LinkedList<Object[]> right) {
            LinkedList<Object[]> mergedList = new LinkedList<>();

            while (!left.isEmpty() && !right.isEmpty()) {
                if ((int) left.peek()[0] <= (int) right.peek()[0]) { // Ordenar de menor a mayor
                    mergedList.add(left.poll());
                } else {
                    mergedList.add(right.poll());
                }
            }

            while (!left.isEmpty()) {
                mergedList.add(left.poll());
            }

            while (!right.isEmpty()) {
                mergedList.add(right.poll());
            }

            return mergedList;
        }
    }
    
        %>
    <h1><=% tree %></h1>
    
    </body>
</html>
