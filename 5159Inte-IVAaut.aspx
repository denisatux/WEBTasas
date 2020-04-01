<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="5159Inte-IVAaut.aspx.vb" Inherits="WEBTasas.FRM_IVAautInte" %>

<%@ Register Assembly="RoderoLib" Namespace="RoderoLib" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Solicitud de Ministraciones</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width=100%>
    <tr>
    <td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #f58220; text-align: center">
        <br />
        Autorización de Tasa de IVA de Intereses</td>
    </tr>
        <tr>
    <td align=center>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ObjectDataSource1" EnableModelValidation="True" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None" DataKeyNames="Anexo,Ciclo">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="Anexo">
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "5159Inte-IVAaut.aspx?User=" & Request("User") & Eval("Anexo", "&Anexo={0}") & Eval("Ciclo", "&Ciclo={0}") %>' Text='<%# Eval("AnexoCon") %>'></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Cliente" HeaderText="Cliente" SortExpression="Cliente" />
                <asp:BoundField DataField="Anexo" HeaderText="Anexo" SortExpression="Anexo" ReadOnly="True" Visible="False" />
                <asp:BoundField DataField="Ciclo" HeaderText="Ciclo" SortExpression="Ciclo" ReadOnly="True" Visible="False" />
            </Columns>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#f58220" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.ProDSTableAdapters.AutorizaIVA_InteresTableAdapter">
        </asp:ObjectDataSource>
        <br />
        <br />
        <asp:DetailsView AutoGenerateRows="False" CellPadding="4" DataSourceID="vwDatos_DS" Font-Names="Verdana" Font-Size="Smaller" ForeColor="#333333" GridLines="None" HorizontalAlign="Center" ID="DetailsView1" runat="server" Width="80%" EnableModelValidation="True" DataKeyNames="Anexo,Ciclo" >
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <RowStyle BackColor="#FFE0C0" />
            <FieldHeaderStyle BackColor="#f58220" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <Fields>
                <asp:BoundField DataField="AnexoCon" HeaderText="Anexo" SortExpression="AnexoCon" />
                <asp:BoundField DataField="Cliente" HeaderText="Cliente" SortExpression="Cliente" />
                <asp:BoundField DataField="TipoCredito" HeaderText="Tipo Credito" SortExpression="TipoCredito" />
                <asp:BoundField DataField="MontoFinanciado" HeaderText="Monto Financiado" SortExpression="MontoFinanciado" />
                <asp:BoundField DataField="IVA" HeaderText="IVA" SortExpression="IVA" />
                <asp:BoundField DataField="Sucursal" HeaderText="Sucursal" SortExpression="Sucursal" />
                <asp:BoundField DataField="CP" HeaderText="CP" SortExpression="CP" />
                <asp:BoundField DataField="Ciudad" HeaderText="Ciudad" SortExpression="Ciudad" />
                <asp:BoundField DataField="Correo" HeaderText="Correo" SortExpression="Correo" />
            </Fields>
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:DetailsView>
        <asp:ObjectDataSource ID="vwDatos_DS" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetDataByAnexo" TypeName="WEBTasas.ProDSTableAdapters.AutorizaIVA_InteresTableAdapter">
            <SelectParameters>
                <asp:QueryStringParameter Name="Anexo" QueryStringField="Anexo" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
    
        <asp:Panel ID="Panel1" runat="server" Height="100%" Width="100%">
            <br />
            <cc1:BotonEnviar ID="BotonEnviar1" runat="server" Font-Bold="True" Text="Autorización"
                TextoEnviando="Autorizando" Width="122px" Font-Size="Smaller" />
            <br />
            <br />
            <cc1:BotonEnviar ID="BotonEnviar2" runat="server" Font-Bold="True" Font-Size="Smaller" Text="Rechazar" TextoEnviando="Rechazando" Width="122px" />
            <br />
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
