<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="951db299-SLCDG.aspx.vb" Inherits="WEBTasas.DGLineaForm" %>

<%@ Register Assembly="RoderoLib" Namespace="RoderoLib" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Solicitud de Linea de Crédito</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width=100%>
    <tr>
    <td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #f58220; text-align: center">
        <br />
        Solicitud de Linea de Credito</td>
    </tr>
        <tr>
    <td align=center>
        <br />
        <asp:DetailsView AutoGenerateRows="False" CellPadding="4" DataSourceID="vwDatos_DS" Font-Names="Verdana" Font-Size="Smaller" ForeColor="#333333" GridLines="None" HorizontalAlign="Center" ID="DetailsView1" runat="server" Width="70%" EnableModelValidation="True" DataKeyNames="Cliente,id_SolicitudLineaDG" >
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <RowStyle BackColor="#FFE0C0" />
            <FieldHeaderStyle BackColor="#f58220" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <Fields>
                <asp:BoundField DataField="Cliente" HeaderText="No. Cliente:" SortExpression="Cliente" ReadOnly="True" />
                <asp:BoundField DataField="Descr" HeaderText="Nombre:" SortExpression="Descr" />
                <asp:BoundField DataField="Usuario" HeaderText="Solicitado por:" SortExpression="Usuario" />
                <asp:BoundField DataField="Tipo" HeaderText="Tipo de Solicitud:" SortExpression="Tipo" />
                <asp:BoundField DataField="Notas" HeaderText="Observaciones:" SortExpression="Notas" />
                <asp:BoundField DataField="Importe" HeaderText="Importe de la Linea:" SortExpression="Importe" DataFormatString="{0:n2}" HtmlEncode="False" />
                <asp:BoundField DataField="id_SolicitudLineaDG" HeaderText="id_SolicitudLineaDG" ReadOnly="True" SortExpression="id_SolicitudLineaDG" InsertVisible="False" Visible="False" />
            </Fields>
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:DetailsView>
        <asp:ObjectDataSource ID="vwDatos_DS" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="WEBTasas.CreditoDSTableAdapters.LineaCreditoDGTableAdapter">
            <SelectParameters>
                <asp:QueryStringParameter Name="id_sol" QueryStringField="ID" Type="String" DefaultValue="0" />
            </SelectParameters>
        </asp:ObjectDataSource>
    
        <asp:Panel ID="Panel1" runat="server" Height="100%" Width="100%">
            <br />
            <cc1:BotonEnviar ID="BotonEnviar1" runat="server" Font-Bold="True" Text="Autorizar"
                TextoEnviando="Autorizando..." Width="122px" Font-Size="Smaller" /><br />
            <br />
        </asp:Panel>
        <br />
        <asp:Label ID="LbError" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="#f58220"
            Text="No hay nada para su autorización"></asp:Label>
        <br />
    </td>
    </tr>
        <tr>
<td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #f58220; text-align: center">
    <br />
    <br />
    </td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
