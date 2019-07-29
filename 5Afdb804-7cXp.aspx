<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="5Afdb804-7cXp.aspx.vb" Inherits="WEBTasas.CPXForm" %>

<%@ Register Assembly="RoderoLib" Namespace="RoderoLib" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Autorización de Gastos y Facturas</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width=100%>
    <tr>
    <td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #ff6600; text-align: center">
        <br />
        Autorizacion de Gastos Y Facturas</td>
    </tr>
        <tr>
    <td align=center>
        <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="idEmpresa,Solicitud,Estatus" DataSourceID="vwDatos_DS" EnableModelValidation="True" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:HyperLinkField DataNavigateUrlFields="User,idEmpresa,Solicitud,Estatus" DataNavigateUrlFormatString="~\5Afdb804-7cXp.aspx?User={0}&amp;ID1={1}&amp;ID2={2}&amp;ID3={3}" Text="Seleccionar">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:HyperLinkField>
                    <asp:BoundField DataField="Empresa" HeaderText="Empresa" SortExpression="Empresa" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:HyperLinkField DataNavigateUrlFields="idEmpresa,Solicitud,Estatus" DataNavigateUrlFormatString="~\tmpFinagil\CXP\{0}-{1}.pdf" DataTextField="Solicitud" DataTextFormatString="{0:n0}" HeaderText="Solicitud" Target="_blank">
                    <ItemStyle Font-Bold="True" HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:HyperLinkField>
                    <asp:BoundField DataField="Solicita" HeaderText="Solicitante" SortExpression="Solicita" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Total" DataFormatString="{0:n2}" HeaderText="Total Solicitado" HtmlEncode="False" ReadOnly="True" SortExpression="Total" >
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Estatus" HeaderText="Estatus" SortExpression="Estatus" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="vwDatos_DS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.ProDSTableAdapters.Vw_CXP_AutorizacionesTableAdapter">
                <SelectParameters>
                    <asp:QueryStringParameter Name="User" QueryStringField="User" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
        <br />
    
        <asp:Panel ID="Panel1" runat="server" Height="100%" Width="100%">
            &nbsp;
            <br />
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="vwDatos_DS0" EnableModelValidation="True" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="nombreProv" HeaderText="Proveedor" SortExpression="nombreProv" />
                    <asp:BoundField DataField="serie" HeaderText="Serie" SortExpression="serie" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:HyperLinkField DataNavigateUrlFields="Root,uuid" DataNavigateUrlFormatString="https:\\finagil.com.mx\WebTasas\{0}\{1}.pdf" DataTextField="folio" HeaderText="Folio" Target="_blank">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:HyperLinkField>
                    <asp:BoundField DataField="total" HeaderText="Total" SortExpression="total" DataFormatString="{0:n2}" HtmlEncode="False" >
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="totalPagado" DataFormatString="{0:n2}" HeaderText="Pago" HtmlEncode="False" SortExpression="totalPagado" >
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="fechaEmision" DataFormatString="{0:d}" HeaderText="Fecha Emision" SortExpression="fechaEmision" HtmlEncode="False" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Parcialidad" DataFormatString="{0:n0}" HeaderText="Parcialidad" SortExpression="Parcialidad" HtmlEncode="False" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="vwDatos_DS0" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.ProDSTableAdapters.Vw_CXP_Autorizaciones_FacturasTableAdapter">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Empresa" QueryStringField="ID1" Type="Decimal" DefaultValue="0" />
                    <asp:QueryStringParameter DefaultValue="0" Name="Solicitud" QueryStringField="ID2" Type="Decimal" />
                    <asp:QueryStringParameter DefaultValue="0" Name="estatus" QueryStringField="ID3" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <br />
            <asp:TextBox ID="TextMail" runat="server" Height="52px" MaxLength="1000" TextMode="MultiLine" Width="320px"></asp:TextBox>
            <br />
            <br />
            <cc1:BotonEnviar ID="BotonAutorizar" runat="server" Font-Bold="True" Font-Size="Smaller" Text="Autorizar" TextoEnviando="Autorizando..." Width="122px" />
            &nbsp;
            <cc1:BotonEnviar ID="BotonRechazar" runat="server" Font-Bold="True" Font-Size="Smaller" Text="Rechazar" TextoEnviando="Rechazando..." Width="122px" />
            &nbsp;
            <cc1:BotonEnviar ID="BotonCorreo" runat="server" Font-Bold="True" Font-Size="Smaller" Text="Correo" Width="122px" />
            <br />
            <br />
            </asp:Panel>
        <asp:Label ID="LbError" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="#FF6600"
            Text="Sin autorizaciones Pendientes"></asp:Label>
        <br />
    </td>
    </tr>
        <tr>
<td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #ff6600; text-align: center">
    <br />
    <br />
    </td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
