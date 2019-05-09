/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import modelo.beans.Categoria;
import modelo.dataBase.ConexionDB;
import org.apache.ibatis.session.SqlSession;

/**
 *
 * @author Juuan
 */
public class CategoriaDAO {

    public static boolean registrarCategoria(Integer idCategoria, String nombre) {
        SqlSession conn = null;
        try {
            //LLAVE   VALOR
            HashMap<String, Object> parametros = new HashMap<String, Object>();
            parametros.put("nombre", nombre);
            parametros.put("idCategoria", idCategoria);

            conn = ConexionDB.getSession();
            int numerofilasafectadas = 0;
            numerofilasafectadas = conn.insert("Categoria.registrar", parametros);
            conn.commit();//SIEMPRE QUE SE EJECUTEN INSERT, UPDATE, DELETE
            if (numerofilasafectadas > 0) {
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return false;
    }

    public static boolean eliminarCategoria(int idCategoria) {
        SqlSession conn = null;
        try {
            conn = ConexionDB.getSession();
            int numerofilasafectadas = 0;
            numerofilasafectadas = conn.insert("Categoria.eliminar", idCategoria);
            conn.commit();
            if (numerofilasafectadas > 0) {
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn == null) {
                conn.close();
            }
        }
        return false;
    }
    
    public static boolean actualizarCategoria(Integer idCategoria, String nombre) {
        SqlSession conn = null;
        try {
            //LLAVE   VALOR
            HashMap<String, Object> parametros = new HashMap<String, Object>();
            parametros.put("nombre", nombre);
            parametros.put("idCategoria", idCategoria);

            conn = ConexionDB.getSession();
            int numerofilasafectadas = 0;
            numerofilasafectadas = conn.insert("Categoria.actualizar", parametros);
            conn.commit();//SIEMPRE QUE SE EJECUTEN INSERT, UPDATE, DELETE
            if (numerofilasafectadas > 0) {
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return false;
    }
    
    //BUSCAR CATEGORIAS POR ROL
    public static List<Categoria> obtenerTodosLosRoles() {
        List<Categoria> categorias = new ArrayList<Categoria>();
        SqlSession conn = null;
        try {
            conn = ConexionDB.getSession();
            categorias = conn.selectList("Categoria.obtenerTodosLosRoles");
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return categorias;
    }
    public static Categoria obtenerRolPorID(String idCategoria) {
        Categoria categoria = new Categoria();
        SqlSession conn = null;
        try {
            conn = ConexionDB.getSession();
            categoria = conn.selectOne("Categoria.obtenerRolPorID",idCategoria);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return categoria;
    }
    
    public static Categoria obtenerRolPorNombre(String nombre) {
        Categoria categoria = new Categoria();
        SqlSession conn = null;
        try {
            conn = ConexionDB.getSession();
            categoria = conn.selectOne("Categoria.obtenerRolPorNombre",nombre);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return categoria;
    }
    
    //BUSCAR CATEGORIAS POR PRENDAS
    public static List<Categoria> obtenerCategoriasPrincipalesPrendas() {
        List<Categoria> categorias = new ArrayList<Categoria>();
        SqlSession conn = null;
        try {
            conn = ConexionDB.getSession();
            categorias = conn.selectList("Categoria.obtenerCategoriasPrincipalesPrendas");
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return categorias;
    }
    
    public static List<Categoria> obtenerSubCategoriasPrendas() {
        List<Categoria> categorias = new ArrayList<Categoria>();
        SqlSession conn = null;
        try {
            conn = ConexionDB.getSession();
            categorias = conn.selectList("Categoria.obtenerSubCategoriasPrendas");
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return categorias;
    }
    
    public static List<Categoria> buscarTodasLasCategoriasDePrendas() {
        List<Categoria> categorias = new ArrayList<Categoria>();
        SqlSession conn = null;
        try {
            conn = ConexionDB.getSession();
            categorias = conn.selectList("Categoria.buscarTodasLasCategoriasDePrendas");
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return categorias;
    }
    
    //BUSCAR CATEGORIAS DE VENTA O APARTADO
    public static List<Categoria> obtenerCategoriasVentaApartado() {
        List<Categoria> categorias = new ArrayList<Categoria>();
        SqlSession conn = null;
        try {
            conn = ConexionDB.getSession();
            categorias = conn.selectList("Categoria.obtenerCategoriasVentaApartado");
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return categorias;
    }
    
    //BUSCAR CATEGORIAS DE PERIODOS
    public static List<Categoria> obtenerCategoriasPeriodos() {
        List<Categoria> categorias = new ArrayList<Categoria>();
        SqlSession conn = null;
        try {
            conn = ConexionDB.getSession();
            categorias = conn.selectList("Categoria.obtenerCategoriasPeriodos");
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return categorias;
    }
    
    //BUSCAR CATEGORIAS DE OCUPACIONES
    public static List<Categoria> obtenerCategoriasOcupacion() {
        List<Categoria> categorias = new ArrayList<Categoria>();
        SqlSession conn = null;
        try {
            conn = ConexionDB.getSession();
            categorias = conn.selectList("Categoria.obtenerCategoriasOcupacion");
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return categorias;
    }
    
    //BUSCAR CATEGORIA DE FORMA GENERAL
    public static Categoria obtenerCategoriaNombre(String nombre) {
        Categoria categoria = new Categoria();
        SqlSession conn = null;
        try {
            conn = ConexionDB.getSession();
            categoria = conn.selectOne("Categoria.obtenerCategoriaNombre",nombre);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return categoria;
    }
}
