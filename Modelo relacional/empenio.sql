-- MySQL Script generated by MySQL Workbench
-- Tue Apr 16 17:18:25 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema empenio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema empenio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `empenio` DEFAULT CHARACTER SET utf8 ;
USE `empenio` ;

-- -----------------------------------------------------
-- Table `empenio`.`Categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empenio`.`Categorias` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  `Categorias_idCategoria` INT NULL,
  PRIMARY KEY (`idCategoria`),
  INDEX `fk_Categorias_Categorias1_idx` (`Categorias_idCategoria` ASC) VISIBLE,
  CONSTRAINT `fk_Categorias_Categorias1`
    FOREIGN KEY (`Categorias_idCategoria`)
    REFERENCES `empenio`.`Categorias` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empenio`.`ParametrosSucursal`
-- Esta tabla solo ocupará una columna
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empenio`.`ParametrosSucursal` (
  `idSucursal` INT NOT NULL AUTO_INCREMENT,
  `fondo` INT NOT NULL, -- Guardado en centavos
  `interesOrdinario` INT NOT NULL,
  `interesAlmacen` INT NOT NULL,
  `tipoPeriodo` INT NOT NULL,
  PRIMARY KEY (`idSucursal`),
  INDEX `fk_ParametrosSucursal_Categorias1_idx` (`tipoPeriodo` ASC) VISIBLE,
  CONSTRAINT `fk_ParametrosSucursal_Categorias1`
    FOREIGN KEY (`tipoPeriodo`)
    REFERENCES `empenio`.`Categorias` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empenio`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empenio`.`Usuario` (
  `numPersonal` INT NOT NULL AUTO_INCREMENT,
  `nombreCompleto` VARCHAR(60) NOT NULL,
  `contrasenia` VARCHAR(45) NOT NULL,
  `rol` INT NOT NULL,
  `fechaIngreso` DATE NOT NULL,
  PRIMARY KEY (`numPersonal`),
  INDEX `fk_Usuario_Categorias1_idx` (`rol` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_Categorias1`
    FOREIGN KEY (`rol`)
    REFERENCES `empenio`.`Categorias` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empenio`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empenio`.`Cliente` (
  `nombre` VARCHAR(30) NOT NULL,
  `apellidoPaterno` VARCHAR(45) NOT NULL,
  `apellidoMaterno` VARCHAR(45) NOT NULL,
  `rfc` VARCHAR(13) NOT NULL,
  `curp` VARCHAR(18) NOT NULL,
  `numeroIdentificacion` VARCHAR(20) NOT NULL,
  `ocupacion` INT NOT NULL,
  `fechaIngreso` DATE NOT NULL,
  PRIMARY KEY (`rfc`),
  INDEX `fk_Cliente_Categorias1_idx` (`ocupacion` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Categorias1`
    FOREIGN KEY (`ocupacion`)
    REFERENCES `empenio`.`Categorias` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empenio`.`Contrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empenio`.`Contrato` (
  `idContrato` INT NOT NULL AUTO_INCREMENT,
  `Cliente_rfc` VARCHAR(13) NOT NULL,
  `Usuario_numPersonal` INT NOT NULL,
  `interesOrdinario` VARCHAR(5) NOT NULL,
  `interesAlmacen` VARCHAR(5) NOT NULL,
  `fechaInicio` DATE NOT NULL,
  `fechaFin` DATE NOT NULL,
  PRIMARY KEY (`idContrato`),
  INDEX `fk_Contrato_Cliente1_idx` (`Cliente_rfc` ASC) VISIBLE,
  INDEX `fk_Contrato_Usuario1_idx` (`Usuario_numPersonal` ASC) VISIBLE,
  CONSTRAINT `fk_Contrato_Cliente1`
    FOREIGN KEY (`Cliente_rfc`)
    REFERENCES `empenio`.`Cliente` (`rfc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contrato_Usuario1`
    FOREIGN KEY (`Usuario_numPersonal`)
    REFERENCES `empenio`.`Usuario` (`numPersonal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empenio`.`Prenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empenio`.`Prenda` (
  `descripcion` VARCHAR(120) NOT NULL,
  `avaluo` FLOAT NOT NULL,
  `prestamo` FLOAT NOT NULL,
  `idPrenda` INT NOT NULL AUTO_INCREMENT,
  `Contrato_idContrato` INT NOT NULL,
  `categoria` INT NOT NULL,
  PRIMARY KEY (`idPrenda`),
  INDEX `fk_Prenda_Contrato1_idx` (`Contrato_idContrato` ASC) VISIBLE,
  INDEX `fk_Prenda_Categorias1_idx` (`categoria` ASC) VISIBLE,
  CONSTRAINT `fk_Prenda_Contrato1`
    FOREIGN KEY (`Contrato_idContrato`)
    REFERENCES `empenio`.`Contrato` (`idContrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prenda_Categorias1`
    FOREIGN KEY (`categoria`)
    REFERENCES `empenio`.`Categorias` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prenda_Categorias2`
    FOREIGN KEY (`tipoProducto`)
    REFERENCES `empenio`.`Categorias` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empenio`.`VentaApartado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empenio`.`VentaApartado` (
  `idVentaApartado` INT NOT NULL AUTO_INCREMENT,
  `monto` FLOAT NOT NULL,
  `fecha` DATE NULL,
  `Cliente_rfc` VARCHAR(13) NOT NULL,
  `Usuario_numPersonal` INT NOT NULL,
  `tipoVenta` INT NOT NULL,
  PRIMARY KEY (`idVentaApartado`),
  INDEX `fk_VentaApartado_Cliente1_idx` (`Cliente_rfc` ASC) VISIBLE,
  INDEX `fk_VentaApartado_Usuario1_idx` (`Usuario_numPersonal` ASC) VISIBLE,
  INDEX `fk_VentaApartado_Categorias1_idx` (`tipoVenta` ASC) VISIBLE,
  CONSTRAINT `fk_VentaApartado_Cliente1`
    FOREIGN KEY (`Cliente_rfc`)
    REFERENCES `empenio`.`Cliente` (`rfc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VentaApartado_Usuario1`
    FOREIGN KEY (`Usuario_numPersonal`)
    REFERENCES `empenio`.`Usuario` (`numPersonal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VentaApartado_Categorias1`
    FOREIGN KEY (`tipoVenta`)
    REFERENCES `empenio`.`Categorias` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empenio`.`fotoCliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empenio`.`fotoCliente` (
  `idfotoCliente` INT NOT NULL,
  `Cliente_rfc` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`idfotoCliente`),
  INDEX `fk_fotoCliente_Cliente1_idx` (`Cliente_rfc` ASC) VISIBLE,
  CONSTRAINT `fk_fotoCliente_Cliente1`
    FOREIGN KEY (`Cliente_rfc`)
    REFERENCES `empenio`.`Cliente` (`rfc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empenio`.`fotoContrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empenio`.`fotoContrato` (
  `idfotoContrato` INT NOT NULL AUTO_INCREMENT,
  `Contrato_idContrato` INT NOT NULL,
  PRIMARY KEY (`idfotoContrato`),
  INDEX `fk_fotoContrato_Contrato1_idx` (`Contrato_idContrato` ASC) VISIBLE,
  CONSTRAINT `fk_fotoContrato_Contrato1`
    FOREIGN KEY (`Contrato_idContrato`)
    REFERENCES `empenio`.`Contrato` (`idContrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empenio`.`Comercializacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empenio`.`Comercializacion` (
  `idComercializacion` INT NOT NULL AUTO_INCREMENT,
  `Usuario_numPersonal` INT NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`idComercializacion`),
  INDEX `fk_Comercializacion_Usuario1_idx` (`Usuario_numPersonal` ASC) VISIBLE,
  CONSTRAINT `fk_Comercializacion_Usuario1`
    FOREIGN KEY (`Usuario_numPersonal`)
    REFERENCES `empenio`.`Usuario` (`numPersonal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empenio`.`Articulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empenio`.`Articulo` (
  `idArticulo` INT NOT NULL AUTO_INCREMENT,
  `Prenda_idPrenda` INT NOT NULL,
  `Nota_idNota` INT NOT NULL,
  `categoria` INT NOT NULL,
  `descripcion` VARCHAR(120) NOT NULL,
  `precio` FLOAT NOT NULL,
  `Articulocol` VARCHAR(45) NOT NULL,
  `Comercializacion_idComercializacion1` INT NOT NULL,
  `tipoProducto` INT NOT NULL,
  PRIMARY KEY (`idArticulo`),
  INDEX `fk_Articulo_Prenda1_idx` (`Prenda_idPrenda` ASC) VISIBLE,
  INDEX `fk_Articulo_Categorias1_idx` (`categoria` ASC) VISIBLE,
  INDEX `fk_Articulo_Comercializacion2_idx` (`Comercializacion_idComercializacion1` ASC) VISIBLE,
  INDEX `fk_Articulo_Categorias2_idx` (`tipoProducto` ASC) VISIBLE,
  CONSTRAINT `fk_Articulo_Prenda1`
    FOREIGN KEY (`Prenda_idPrenda`)
    REFERENCES `empenio`.`Prenda` (`idPrenda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Articulo_Categorias1`
    FOREIGN KEY (`categoria`)
    REFERENCES `empenio`.`Categorias` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Articulo_Comercializacion2`
    FOREIGN KEY (`Comercializacion_idComercializacion1`)
    REFERENCES `empenio`.`Comercializacion` (`idComercializacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Articulo_Categorias2`
    FOREIGN KEY (`tipoProducto`)
    REFERENCES `empenio`.`Categorias` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empenio`.`Periodo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empenio`.`Periodo` (
  `idPeriodo` INT NOT NULL AUTO_INCREMENT,
  `Contrato_idContrato` INT NOT NULL,
  `fechaInicio` DATE NOT NULL,
  `fechaFin` DATE NOT NULL,
  `montoRefrendo` FLOAT NOT NULL,
  `tipoPeriodo` INT NOT NULL,
  `montoFiniquito` FLOAT NOT NULL,
  PRIMARY KEY (`idPeriodo`),
  INDEX `fk_Periodo_Contrato1_idx` (`Contrato_idContrato` ASC) VISIBLE,
  INDEX `fk_Periodo_Categorias1_idx` (`tipoPeriodo` ASC) VISIBLE,
  CONSTRAINT `fk_Periodo_Contrato1`
    FOREIGN KEY (`Contrato_idContrato`)
    REFERENCES `empenio`.`Contrato` (`idContrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Periodo_Categorias1`
    FOREIGN KEY (`tipoPeriodo`)
    REFERENCES `empenio`.`Categorias` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empenio`.`Ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empenio`.`Ticket` (
  `Venta/apartado` INT NOT NULL,
  `Articulo_idArticulo` INT NOT NULL,
  INDEX `fk_Venta/apartado_has_Articulo_Articulo1_idx` (`Articulo_idArticulo` ASC) VISIBLE,
  INDEX `fk_Venta/apartado_has_Articulo_Venta/apartado1_idx` (`Venta/apartado` ASC) VISIBLE,
  CONSTRAINT `fk_Venta/apartado_has_Articulo_Venta/apartado1`
    FOREIGN KEY (`Venta/apartado`)
    REFERENCES `empenio`.`VentaApartado` (`idVentaApartado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venta/apartado_has_Articulo_Articulo1`
    FOREIGN KEY (`Articulo_idArticulo`)
    REFERENCES `empenio`.`Articulo` (`idArticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE USER 'isof19'@'localhost' IDENTIFIED BY 'isof19';
GRANT ALL PRIVILEGES ON * . * TO 'isof19'@'localhost';

-- Creacion de las categorias principales de Roles del usuario
INSERT INTO categorias (nombre) VALUES ('Rol');-- ID = 1
-- Creacion de la categoria ORO de prenda y articulo
INSERT INTO categorias (nombre) VALUES ('Oro');-- ID = 2
-- Creacion de la categoria PRODUCTO de prenda y articulo
INSERT INTO categorias (nombre) VALUES ('Producto');-- ID = 3
-- Creacion de las categorias de venta y apartado
INSERT INTO categorias (nombre) VALUES ('Venta/apartado');-- ID = 4
-- Creacion de tipos de periodos
INSERT INTO categorias (nombre) VALUES ('Periodo');-- ID = 5
-- Creacion de los tipos de ocupacion de los clientes
INSERT INTO categorias (nombre) VALUES ('Ocupacion');-- ID = 6

-- Creacion de los roles de los usuarios
INSERT INTO categorias (nombre, Categorias_idCategoria) VALUES ('Administrador', '1');
INSERT INTO categorias (nombre, Categorias_idCategoria) VALUES ('Cajero', '1');
INSERT INTO categorias (nombre, Categorias_idCategoria) VALUES ('Gerente', '1');
INSERT INTO categorias (nombre, Categorias_idCategoria) VALUES ('Bodeguero', '1');

-- Creacion de las subcategorias de venta y apartado
INSERT INTO categorias (nombre, Categorias_idCategoria) VALUES ('Venta', '4');
INSERT INTO categorias (nombre, Categorias_idCategoria) VALUES ('Apartado', '4');

-- Creacion de las subcategorias para los periodos
INSERT INTO categorias (nombre, Categorias_idCategoria) VALUES ('Semanal', '5');
INSERT INTO categorias (nombre, Categorias_idCategoria) VALUES ('Quincenal', '5');
INSERT INTO categorias (nombre, Categorias_idCategoria) VALUES ('Mensual', '5');

-- Creacion de las subcategorias de ocupacion
INSERT INTO categorias (nombre, Categorias_idCategoria) VALUES ('Maestro', '6');
INSERT INTO categorias (nombre, Categorias_idCategoria) VALUES ('Ingeniero', '6');
INSERT INTO categorias (nombre, Categorias_idCategoria) VALUES ('Ama de casa', '6');
INSERT INTO categorias (nombre, Categorias_idCategoria) VALUES ('Carpitero', '6');
INSERT INTO categorias (nombre, Categorias_idCategoria) VALUES ('Mecanico', '6');

-- Creación de parámetros de la sucursal
INSERT INTO parametrossucursal (fondo, interesOrdinario, interesAlmacen, tipoPeriodo) VALUES (8000000, 8, 2, 14);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
