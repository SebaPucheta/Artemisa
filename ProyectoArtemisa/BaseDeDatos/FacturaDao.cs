﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Sql;
using System.Data.SqlClient;
using Entidades;

namespace BaseDeDatos
{
    public class FacturaDao : Conexion
    {
        public static list<FacturaEntidadQuery> ListarFacturas()
        {
            string query = @"SELECT f.idFactura, f.fecha, f.total, tp.descripcion
                            FROM Factura f INNER JOIN TipoPago tp ON f.idTipoPago = tp.idTipoPago";
            SqlCommand cmd = new SqlCommand(query, obtenerBD());
            SqlDataReader dr = cmd.ExecuteReader();
            List<FacturaEntidadQuery> lista = new List<FacturaEntidadQuery>();
            while (dr.Read())
            {
                FacturaEntidadQuery factura = new FacturaEntidadQuery();
                factura.idFactura = int.Parse(dr["idFactura"].ToString());
                factura.fecha = DateTime.Parse(dr["fecha"].ToString());
                factura.total = float.Parse(dr["total"].ToString());
                factura.descripcion = dr["descripcion"].ToString();
                lista.Add(factura);
            }
            dr.Close();
            cmd.Connection.Close();
            return lista;
        }
    }
}