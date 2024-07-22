/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author mych7
 */
import java.util.ArrayList;
import java.util.List;

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