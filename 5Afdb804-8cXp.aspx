<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="5Afdb804-8cXp.aspx.vb" Inherits="WEBTasas.CPXForm8" Culture="es-MX" uiCulture="es-MX" %>

<%@ Register Assembly="RoderoLib" Namespace="RoderoLib" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Autorización de Gastos</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width=100%>
    <tr>
    <td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #ff6600; text-align: center">
        <br />
        Autorización de Gastos</td>
    </tr>
        <tr>
    <td align=center>
        <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="idEmpresa,FolioComprobante" DataSourceID="vwDatos_DS" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField ShowSelectButton="True" ButtonType="Image" SelectImageUrl="~/IMG/check1.JPG" />
                    <asp:BoundField DataField="Empresa" HeaderText="Empresa" SortExpression="Empresa" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:HyperLinkField DataNavigateUrlFields="idEmpresa,FolioComprobante" DataNavigateUrlFormatString="~\tmpFinagil\GTS\{0}-{1}.pdf" DataTextField="FolioComprobante" DataTextFormatString="{0:n0}" HeaderText="Solicitud" Target="_blank">
                    <ItemStyle Font-Bold="True" HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:HyperLinkField>
                    <asp:BoundField DataField="nombre" HeaderText="Solicitante" SortExpression="Solicita" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="totalPagado" DataFormatString="{0:n2}" HeaderText="Total Solicitado" HtmlEncode="False" ReadOnly="True" SortExpression="Total" >
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="vwDatos_DS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.ProDSTableAdapters.Vw_CXP_ComprobacionGastosResumTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="User" SessionField="User" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
        <br />
    
        <asp:Panel ID="Panel1" runat="server" Height="100%" Width="100%">
            &nbsp;
            <br />
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="vwDatos_DS0" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="razonSocial" HeaderText="Proveedor" SortExpression="nombreProv" />
                    <asp:BoundField DataField="serie" HeaderText="Serie" SortExpression="serie" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:HyperLinkField DataNavigateUrlFields="Root,uuid" DataNavigateUrlFormatString="https:\\finagil.com.mx\WebTasas\{0}\{1}.pdf" DataTextField="folio" HeaderText="Folio" Target="_blank">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:HyperLinkField>
                    <asp:BoundField DataField="importe" DataFormatString="{0:n2}" HeaderText="Pago" HtmlEncode="False" SortExpression="importe" >
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="fechaComprobacion" DataFormatString="{0:d}" HeaderText="Fecha Emision" SortExpression="fechaEmision" HtmlEncode="False" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="vwDatos_DS0" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.ProDSTableAdapters.Vw_CXP_ComprobacionGastosTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="0" Name="Empresa" SessionField="ID1" Type="Decimal" />
                    <asp:SessionParameter DefaultValue="" Name="folioComprobacion" SessionField="ID2" Type="Decimal" />
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
    <asp:Label ID="Label1" runat="server" Text="." Font-Size="Smaller"></asp:Label>
    <br />
    </td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
