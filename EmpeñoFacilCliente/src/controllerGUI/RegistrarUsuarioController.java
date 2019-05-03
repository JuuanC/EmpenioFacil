/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllerGUI;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.input.KeyEvent;
import javafx.stage.Stage;
import javax.swing.JOptionPane;
import modelo.beans.Categoria;
import modelo.dao.CategoriaDAO;
import modelo.dao.UsuarioDAO;

/**
 * FXML Controller class
 *
 * @author Juuan
 */
public class RegistrarUsuarioController implements Initializable {
    
    /**
     * Initializes the controller class.
     */
    
    public RegistrarUsuarioController(String tipo){
        this.tipo = tipo;
    }
    
    private String nombre;
    private String contrasenia;
    private String rol;
    private static String tipo;
    
    @FXML
    private Button guardarBtn;

    @FXML
    private ComboBox<String> rolCbx;

    @FXML
    private Button cancelarBtn;

    @FXML
    private TextField nombreTxt;

    @FXML
    private PasswordField contraseniaTxt;

    public boolean validarCampos() {
        nombre = nombreTxt.getText();
        contrasenia = contraseniaTxt.getText();
        rol = rolCbx.getValue();
        if(nombre != null && contrasenia != null && rol != null
                && nombre.trim().length()>0 && contrasenia.trim().length()>0){
            return true;
        }
        return false;
    }

    @FXML
    void cancelar(ActionEvent event) {
        Parent root;
        ((Node)(event.getSource())).getScene().getWindow().hide(); 
    }

    @FXML
    void guardar(ActionEvent event) {
        nombre = nombreTxt.getText();
        contrasenia = contraseniaTxt.getText();
        rol = rolCbx.getValue();
        int idrol = 0;
        for (int i = 0; i < categorias.size(); i++) {
            if (categorias.get(i).getNombre().equals(rol)) {
                idrol = categorias.get(i).getIdCategoria();
            }
        }
        if (validarCampos()) {
            if (UsuarioDAO.registrarUsuario(nombre, contrasenia, Integer.toString(idrol))) {
                JOptionPane.showMessageDialog(null, "Usuario guardado exitosamente."); 
                ((Node)(event.getSource())).getScene().getWindow().hide(); 
            } else {
                JOptionPane.showMessageDialog(null, "No se pudo registrar al usuario");
            }
        } else {
            JOptionPane.showMessageDialog(null, "Los datos del usuario son incorrectos.");
        }
    }

    private List<Categoria> categorias;

    public void cargarRoles() {
        categorias = new ArrayList<Categoria>();
        categorias = CategoriaDAO.buscarCategoriasRoles();
        ObservableList<String> acciones = FXCollections.observableArrayList();
        for (int i = 0; i < categorias.size(); i++) {
            acciones.add(categorias.get(i).getNombre());
        }
        rolCbx.setItems(acciones);
    }

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        cargarRoles();
        System.out.println("el tipo es: " + tipo);
    }

}
