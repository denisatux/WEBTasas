<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="232db951-oiva.aspx.vb" Inherits="WEBTasas.JefeSucursalForm" %>

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
    <td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #ff6600; text-align: center">
        <br />
        Solicitud de Ministraciones
        <br />
    </td>
    </tr>
        <tr>
    <td align=center>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ObjectDataSource1" EnableModelValidation="True" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="Anexo">
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("Vobo", "232db951-oiva.aspx?User={0:F0}") & Eval("Anexo", "&Anexo={0:F0}") & Eval("Ministracion", "&ID={0:F0}") & Eval("CicloPagare", "&CicloPagare={0:F0}") %>' Text='<%# Eval("AnexoCon") %>'></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="AnexoCon" HeaderText="Anexo" SortExpression="AnexoCon" />
                <asp:BoundField DataField="CicloPagare" HeaderText="Ciclo" SortExpression="CicloPagare" />
                <asp:BoundField DataField="Descr" HeaderText="Cliente" SortExpression="Descr" />
                <asp:BoundField DataField="Ministracion" HeaderText="Ministracion" SortExpression="Ministracion" />
                <asp:BoundField DataField="Documento" HeaderText="Concepto" SortExpression="Documento" />
                <asp:BoundField DataField="Importe" DataFormatString="{0:n2}" HeaderText="Importe" HtmlEncode="False" SortExpression="Importe" />
                <asp:BoundField DataField="Solicito" HeaderText="Solicito" SortExpression="Solicito" />
                <asp:BoundField DataField="FechaAlta" DataFormatString="{0:d}" HeaderText="Fecha Alta" HtmlEncode="False" ReadOnly="True" SortExpression="FechaAlta" />
                <asp:BoundField DataField="TipoCredito" HeaderText="TipoCredito" SortExpression="TipoCredito" />
                <asp:BoundField DataField="Cultivo" HeaderText="Cultivo" SortExpression="Cultivo" />
                <asp:BoundField DataField="Anexo" HeaderText="Anexo" SortExpression="Anexo" Visible="False" />
                <asp:BoundField DataField="Nombre_Sucursal" HeaderText="Sucursal" SortExpression="Nombre_Sucursal" />
            </Columns>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.ProDSTableAdapters.AvioVoboTableAdapter">
            <SelectParameters>
                <asp:QueryStringParameter Name="User" QueryStringField="User" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <br />
        <br />
        <asp:DetailsView AutoGenerateRows="False" CellPadding="4" DataSourceID="vwDatos_DS" Font-Names="Verdana" Font-Size="Smaller" ForeColor="#333333" GridLines="None" HorizontalAlign="Center" ID="DetailsView1" runat="server" Width="80%" EnableModelValidation="True" >
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <RowStyle BackColor="#FFE0C0" />
            <FieldHeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <Fields>
                <asp:BoundField DataField="AnexoCon" HeaderText="Anexo" SortExpression="AnexoCon" />
                <asp:BoundField DataField="CicloPagare" HeaderText="Ciclo" SortExpression="CicloPagare" />
                <asp:BoundField DataField="Descr" HeaderText="Cliente" SortExpression="Descr" />
                <asp:BoundField DataField="Importe" HeaderText="Importe" SortExpression="Importe" DataFormatString="{0:n2}" HtmlEncode="False" />
                <asp:BoundField DataField="Solicito" HeaderText="Solicito" SortExpression="Solicito" />
                <asp:BoundField DataField="Documento" HeaderText="Concepto" SortExpression="Documento" />
                <asp:BoundField DataField="FechaAlta" DataFormatString="{0:d}" HeaderText="FechaAlta" HtmlEncode="False" ReadOnly="True" SortExpression="FechaAlta" />
                <asp:BoundField DataField="Ministracion" HeaderText="Ministracion" SortExpression="Ministracion" Visible="False" />
                <asp:BoundField DataField="Anexo" HeaderText="Anexo" SortExpression="Anexo" Visible="False" />
            </Fields>
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:DetailsView>
        <asp:ObjectDataSource ID="vwDatos_DS" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetDataByMinistracion" TypeName="WEBTasas.ProDSTableAdapters.AvioVoboTableAdapter">
            <SelectParameters>
                <asp:QueryStringParameter Name="Anexo" QueryStringField="Anexo" Type="String" />
                <asp:QueryStringParameter Name="Ministracion" QueryStringField="ID" Type="Byte" />
                <asp:QueryStringParameter Name="CicloPagare" QueryStringField="CicloPagare" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
    
        <asp:Panel ID="Panel1" runat="server" Height="100%" Width="100%">
            <table align="center" width="100%">
                <tr>
                    <td width="25%"></td>
                    <td width="50%" align="justify">
                        <asp:CheckBox ID="CheckAviso" runat="server" AutoPostBack="True" Visible="False" />
                    </td>
                    <td width="25%"></td>
                </tr>
            </table>
            <br />
            <cc1:BotonEnviar ID="BotonEnviar1" runat="server" Font-Bold="True" Text="V.o.b.o."
                TextoEnviando="V.o.b.o..." Width="122px" Font-Size="Smaller" Enabled="False" />
            <br />
            <br />
            <cc1:BotonEnviar ID="BotonEnviar2" runat="server" Font-Bold="True" Font-Size="Smaller" Text="Pasa (Estrategias)" TextoEnviando="Pasa (Estrategias)" Width="122px" />
            <br />
            <br />
        </asp:Panel>
        <br />
        <asp:Label ID="LbError" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="#FF6600"
            Text="No hay nada para visto bueno."></asp:Label>
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
