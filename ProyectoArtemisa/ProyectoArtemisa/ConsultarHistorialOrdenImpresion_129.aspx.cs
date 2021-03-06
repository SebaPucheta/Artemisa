﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entidades;
using BaseDeDatos;
using System.Data;


namespace ProyectoArtemisa
{
    public partial class ConsultarHistorialOrdenImpresion_129 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
            }
        }
        protected void cargarGrillaOrdenImpresion(List<OrdenImpresionEntidadQuery> listaOrdenesImpresion)
        {
            DataTable tabla = new DataTable();
            DataRow fila;

            //Creo las columnas de la tabla
            tabla.Columns.Add("idOrdenImpresion", typeof(int));//key name
            tabla.Columns.Add("cantidad", typeof(string));
            tabla.Columns.Add("fecha", typeof(string));
            tabla.Columns.Add("nombre", typeof(string));
            tabla.Columns.Add("estado", typeof(string));           

            foreach (OrdenImpresionEntidadQuery ordenImpresion in listaOrdenesImpresion)
            {
                
                fila = tabla.NewRow();

                fila[0] = ordenImpresion.idOrdenImpresion;
                fila[1] = ordenImpresion.cantidad +" Unidades";
                fila[2] = ordenImpresion.fecha.ToString();
                fila[3] = ordenImpresion.nombreApunte;
                fila[4] = ordenImpresion.nombreEstadoOrdenImpresion;
            
                tabla.Rows.Add(fila);
            }

            DataView dataView = new DataView(tabla);

            dgv_grillaOrdenesImpresion.DataSource = dataView;
            dgv_grillaOrdenesImpresion.DataKeyNames = new string[] { "idOrdenImpresion" };
            dgv_grillaOrdenesImpresion.DataBind();
            lbl_nombreGrilla.Visible = true;
        }
        protected void dgv_grilla_OnPageIndexChanging(Object sender, GridViewPageEventArgs e)
        {
            dgv_grillaOrdenesImpresion.PageIndex = e.NewPageIndex;
            cargarGrillaOrdenImpresion(OrdenImpresionDao.ListarOrdenesImpresion(txt_fechaDesde.Text, txt_fechaHasta.Text));
        }
        protected void btn_confirmar_Click(object sender, EventArgs e)
        {
            cargarGrillaOrdenImpresion(OrdenImpresionDao.ListarOrdenesImpresion(txt_fechaDesde.Text, txt_fechaHasta.Text));
        }
    }
}