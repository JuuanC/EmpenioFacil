/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllerGUI;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.input.KeyEvent;
import javafx.stage.Stage;
import javax.swing.JOptionPane;
import modelo.beans.Usuario;
import modelo.dao.UsuarioDAO;
import utileria.Validar;

/**
 * FXML Controller class
 *
 * @author Juuan
 */
public class IniciarSesionController implements Initializable {

    private String contrasenia;
    private String numPersonal;
    
    @FXML
    private Button iniciarSesionBtn;

    @FXML
    private PasswordField contraseniaTxt;

    @FXML
    private TextField numeroDePersonalTxt;

    @FXML
    void iniciarSesion(ActionEvent event) {
        if (validarCampos()) {
            if (existe()) {
                Parent root;
                try {
                    root = FXMLLoader.load(getClass().getResource("/gui/Principal.fxml"));
                    Stage escenario = new Stage();
                    Scene scene = new Scene(root);
                    escenario.setScene(scene);
                    escenario.show();
                    ((Node)(event.getSource())).getScene().getWindow().hide(); 
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
            } else {
                JOptionPane.showMessageDialog(null, "El usuario no esta registrado.");
            }
        } else {
            JOptionPane.showMessageDialog(null, "Los datos del usuario son incorrectos.");
        }
    }

    public boolean validarCampos() {
        contrasenia = contraseniaTxt.getText();
        numPersonal = numeroDePersonalTxt.getText();
        if ((contrasenia != null && numPersonal != null) && (contrasenia.trim().length() > 0 && numPersonal.trim().length() > 0)) {
            if (Validar.validarCadenaEntero(contrasenia) && Validar.validarEntero(numPersonal)) {
                return true;
            }
        }
        return false;
    }

    public boolean existe() {
        contrasenia = contraseniaTxt.getText();
        numPersonal = numeroDePersonalTxt.getText();
        if (UsuarioDAO.buscarUsuarioParaLogin(numPersonal, contrasenia) == 0) {
            return false;
        }
        return true;
    }

    @Override
    public void initialize(URL url, ResourceBundle rb) {

    }

}
