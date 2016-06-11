﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades;
<<<<<<< HEAD
using System.Data.Sql;
using System.Data.SqlClient;



namespace BaseDeDatos
{
    public class UniversidadDao: Conexion
    {
        public static List<UniversidadEntidad> consultarUniversidad()
        {
            List<UniversidadEntidad> listaUni = new List<UniversidadEntidad>();
            string query = "Select * FROM Universidad";
            SqlCommand cmd = new SqlCommand(query, obtenerBD());
            SqlDataReader dr = cmd.ExecuteReader();

=======
using System.Data.SqlClient;

namespace BaseDeDatos
{
    public class UniversidadDao : Conexion
    {

        /// <summary>
        /// Registra una universidad recibiendo un objeto universidad
        /// </summary>
        public static void RegistrarUniversidad(UniversidadEntidad uni)
        {
            string consulta = @"INSERT INTO Universidad (nombre) VALUES (@nom)";
            SqlCommand cmd = new SqlCommand(consulta, obtenerBD());
            cmd.Parameters.AddWithValue(@"nom", uni.nombreUniversidad);
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();
        }

        /// <summary>
        /// Consulta todas las universidades registradas en la base de datos
        /// </summary>
        /// <returns>Lista de objetos universidad</returns>
        public static List<UniversidadEntidad> ConsultarUniversidad()
        {
            List<UniversidadEntidad> lista = new List<UniversidadEntidad>();
            string consulta = @"SELECT idUniversidad, nombre FROM Universidad";
            SqlCommand cmd = new SqlCommand(consulta, obtenerBD());

            SqlDataReader dr = cmd.ExecuteReader();
>>>>>>> origin/master
            while (dr.Read())
            {
                UniversidadEntidad uni = new UniversidadEntidad();
                uni.idUniversidad = int.Parse(dr["idUniversidad"].ToString());
                uni.nombreUniversidad = dr["nombre"].ToString();
<<<<<<< HEAD
                listaUni.Add(uni);
            }

            dr.Close();
            cmd.Connection.Close();
            return listaUni;

        }
=======
                lista.Add(uni);
            }
            dr.Close();
            cmd.Connection.Close();
            return lista;
        }

        /// <summary>
        /// Modifica una universidad recibiendo un objeto universidad
        /// </summary>
        public static void ModificarUniversidad(UniversidadEntidad uni)
        {
            string consulta = @"UPDATE Universidad nombre = @nom)";
            SqlCommand cmd = new SqlCommand(consulta, obtenerBD());
            cmd.Parameters.AddWithValue(@"nom", uni.nombreUniversidad);
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();
        }


>>>>>>> origin/master
    }
}
