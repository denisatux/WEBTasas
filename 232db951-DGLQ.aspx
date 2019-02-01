<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="232db951-DGLQ.aspx.vb" Inherits="WEBTasas.DGSucursalLQForm" %>

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
        Autoirización Liquedez Inmediata</td>
    </tr>
        <tr>
    <td align=center>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ObjectDataSource1" EnableModelValidation="True" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None" DataKeyNames="Id_Solicitud">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="Solicitud" InsertVisible="False" SortExpression="Id_Solicitud">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Id_Solicitud") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("Estatus", "232db951-DGLQ.aspx?User={0:F0}") & Eval("id_solicitud", "&ID={0:F0}") %>' Text='<%# Eval("Id_Solicitud", "{0}") %>'></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Cliente" HeaderText="Cliente" SortExpression="Cliente" />
                <asp:BoundField DataField="Fecha" HeaderText="Fecha" SortExpression="Fecha" DataFormatString="{0:d}" HtmlEncode="False" />
                <asp:BoundField DataField="MontoFinanciado" HeaderText="MontoFinanciado" SortExpression="MontoFinanciado" DataFormatString="{0:n2}" HtmlEncode="False" />
            </Columns>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.ProDSTableAdapters.SolLiqTableAdapter">
            <SelectParameters>
                <asp:QueryStringParameter Name="User" QueryStringField="User" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <br />
        <br />
        <asp:DetailsView AutoGenerateRows="False" CellPadding="4" DataSourceID="vwDatos_DS" Font-Names="Verdana" Font-Size="Smaller" ForeColor="#333333" GridLines="None" HorizontalAlign="Center" ID="DetailsView1" runat="server" Width="80%" EnableModelValidation="True" DataKeyNames="Id_Solicitud" >
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <RowStyle BackColor="#FFE0C0" />
            <FieldHeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <Fields>
                <asp:BoundField DataField="Id_Solicitud" HeaderText="Solicitud" SortExpression="Id_Solicitud" DataFormatString="{0}" HtmlEncode="False" InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="Cliente" HeaderText="Cliente" SortExpression="Cliente" />
                <asp:BoundField DataField="MontoFinanciado" HeaderText="MontoFinanciado" SortExpression="MontoFinanciado" DataFormatString="{0:n2}" />
                <asp:BoundField DataField="Plazo" HeaderText="Plazo" SortExpression="Plazo" />
                <asp:BoundField DataField="NotaParaDG" HeaderText="Nota" SortExpression="NotaParaDG" />
                <asp:BoundField DataField="condiciones" HeaderText="Condiciones" SortExpression="condiciones" />
                <asp:BoundField DataField="observaciones" HeaderText="Observaciones" SortExpression="observaciones" />
                <asp:BoundField DataField="tasa" HeaderText="Tasa" SortExpression="tasa" />
                <asp:BoundField DataField="bc" HeaderText="Buro de Crédito" SortExpression="bc" />
                <asp:HyperLinkField DataNavigateUrlFields="Id_Solicitud" DataNavigateUrlFormatString="~\TmpFinagil\Autoriza{0}.pdf" DataTextField="Id_Solicitud" DataTextFormatString="Autorización {0}" HeaderText="Autorización" />
            </Fields>
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:DetailsView>
        <asp:ObjectDataSource ID="vwDatos_DS" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="WEBTasas.ProDSTableAdapters.SolLiqDetTableAdapter">
            <SelectParameters>
                <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Decimal" DefaultValue="0" />
            </SelectParameters>
        </asp:ObjectDataSource>
    
        <asp:Panel ID="Panel1" runat="server" Height="100%" Width="100%">
            <br />
            <cc1:BotonEnviar ID="BotonEnviar1" runat="server" Font-Bold="True" Text="V.o.b.o."
                TextoEnviando="V.o.b.o..." Width="122px" Font-Size="Smaller" /><br />
            <br />
        </asp:Panel>
        <br />
        <asp:Label ID="LbError" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="#FF6600"
            Text="No hay nada para su autorización"></asp:Label>
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
