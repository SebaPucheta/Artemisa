﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Menu.Master" AutoEventWireup="true" CodeBehind="ConsultarHistorialOrdenImpresion_129.aspx.cs" Inherits="ProyectoArtemisa.ConsultarHistorialOrdenImpresion_129" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_encabezado" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_cuerpo" runat="server">

    <div class="container col-lg-offset-3 col-lg-7" id="div_form">
        <div class="form-group">

            <!-- Titulo -->
            <div class="row">
                <h1 class="text-primary text-center"><b>Historial de Órdenes de Impresión</b></h1>
            </div>
            <br />

            <!-- Fecha desde  -->
            <div class="row">
                <div class="form-group">
                    <label for="documento" class="control-label col-md-2">Fecha desde: </label>
                    <div class="col-md-2">
                        <!--Le quito el TextMode="Date" y le coloco jquery Autor: Martin-->
                        <asp:TextBox runat="server" class="form-control" type="text" ID="txt_fechaDesde" placeholder="dd/mm/aaaa" value="" ViewStateMode="Enabled" />
                    </div>
                </div>
            </div>
            <br />

            <!-- Fecha hasta  -->
            <div class="row">
                <div class="form-group">
                    <label for="documento" class="control-label col-md-2">Fecha hasta: </label>
                    <div class="col-md-2">
                        <!--Le quito el TextMode="Date" y le coloco jquery Autor: Martin-->
                        <asp:TextBox runat="server" class="form-control" type="text" ID="txt_fechaHasta" placeholder="dd/mm/aaaa" value="" ViewStateMode="Enabled" />
                    </div>
                </div>
            </div>
            <br />


            <div class="col-lg-offset-9">
                <asp:Button runat="server" ID="btn_confirmar" Text="Buscar" CssClass="btn btn-lg btn_azul btn_flat" Enabled="true" OnClick="btn_confirmar_Click" />
            </div>
            <br />
            <br />
             <!-- Subtitulo de grilla -->
            <div class="row">
                <div class="form-group">
                    <asp:label runat="server" ID="lbl_nombreGrilla" Visible="false" for="cuil" class="control-label col-md-5"><b>Lista de órdenes de impresión</b></asp:label>
                </div>
            </div>
            <!-- Grilla Ordenes de Impresion-->
            <asp:GridView ID="dgv_grillaOrdenesImpresion" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False"  AllowPaging="True" PageSize="20"
            OnPageIndexChanging="dgv_grilla_OnPageIndexChanging">
                <HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#ffffcc" />
                <EmptyDataRowStyle ForeColor="Red" CssClass="table table-bordered" />
                <Columns>
                    <asp:BoundField DataField="nombre"  ItemStyle-HorizontalAlign="Center" HeaderText="Nombre" />
                    <asp:BoundField DataField="cantidad"  ItemStyle-HorizontalAlign="Center" HeaderText="Cantidad" ApplyFormatInEditMode="False" />
                    <asp:BoundField DataField="fecha"  ItemStyle-HorizontalAlign="Center" HeaderText="Fecha" DataFormatString="{0:d}" />
                    <asp:BoundField DataField="estado"  ItemStyle-HorizontalAlign="Center" HeaderText="Estado" />

                </Columns>
            </asp:GridView>
            <br />

            <br />
            <br />
        </div>
    </div>

</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder_pie" runat="server">
    <%-- Son los JQUERY para los datapicker Autor: Martin--%>
    <script>
        $(function () {
            $("#<%= txt_fechaDesde.ClientID %>").datepicker({ dateFormat: 'dd/mm/yy' }).val();
        });
    </script>
    <script>
        $(function () {
            $("#<%= txt_fechaHasta.ClientID %>").datepicker({ dateFormat: 'dd/mm/yy' }).val();
    });
    </script>
</asp:Content>
