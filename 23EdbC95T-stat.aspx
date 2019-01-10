<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="23EdbC95T-stat.aspx.vb" Inherits="WEBTasas.ASPX_Estatus" %>

<%@ Register Assembly="RoderoLib" Namespace="RoderoLib" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Solicitud de Ministraciones</title>
    <style type="text/css">
        .auto-style1 {
            font-family: Verdana;
            font-weight: bold;
            color: #FF6600;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width=100%>
    <tr>
    <td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #ff6600; text-align: center">
        <br />
        Estatus de Solicitudes de Ministraciones</td>
    </tr>
        <tr>
    <td align=center>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ObjectDataSource1" EnableModelValidation="True" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Nombre_Sucursal" HeaderText="Sucursal" SortExpression="Nombre_Sucursal" />
                <asp:BoundField DataField="Vobo" HeaderText="Persona" SortExpression="Vobo" />
                <asp:TemplateField HeaderText="Ministraciones" SortExpression="Pendientes">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Pendientes") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Pendientes") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="Status" HeaderText="Estatus" SortExpression="Status" />
                <asp:BoundField DataField="Total" DataFormatString="{0:n2}" HeaderText="Total" HtmlEncode="False" SortExpression="Total">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.ProDSTableAdapters.StatusMinistracionesTableAdapter">
        </asp:ObjectDataSource>
        <br />
    
        <asp:Panel ID="Panel1" runat="server" Height="100%" Width="100%">
            <span class="auto-style1">Avío y Cuenta Corriente</span><asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ObjectDataSource2" EnableModelValidation="True" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Nombre_Sucursal" HeaderText="Sucursal" SortExpression="Nombre_Sucursal" />
                    <asp:BoundField DataField="Vobo" HeaderText="Persona" SortExpression="Vobo" />
                    <asp:BoundField DataField="Anexo" HeaderText="Anexo" SortExpression="Anexo" />
                    <asp:BoundField DataField="descr" HeaderText="Cliente" SortExpression="descr" />
                    <asp:BoundField DataField="Ministracion" HeaderText="Ministración" SortExpression="Ministracion">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Documento" HeaderText="Documento" SortExpression="Documento" />
                    <asp:BoundField DataField="importe" DataFormatString="{0:n2}" HeaderText="Importe" HtmlEncode="False" SortExpression="importe">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Status" HeaderText="Estatus" SortExpression="Status" />
                    <asp:BoundField DataField="FechaSolicitud" DataFormatString="{0:d}" HeaderText="Fecha Solicitud" HtmlEncode="False" SortExpression="FechaSolicitud">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TipoCredito" HeaderText="Tipo Crédito" ReadOnly="True" SortExpression="TipoCredito" />
                    <asp:BoundField DataField="Notas" HeaderText="Notas MC" ReadOnly="True" SortExpression="Notas" />
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.ProDSTableAdapters.StatusMinistracionesDETTableAdapter"></asp:ObjectDataSource>
        </asp:Panel>
        <br />
        <asp:Label ID="LbError" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="#FF6600"
            Text="No hay nada Pendiente"></asp:Label>
        <br />
    </td>
    </tr>
        <tr>
    <td align=center>
        <br />
        <asp:Label ID="LbError0" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="#FF6600"
            Text="Creditos Tradicionales"></asp:Label>
            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ObjectDataSource3" EnableModelValidation="True" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Sucursal" HeaderText="Sucursal" SortExpression="Sucursal" />
                    <asp:BoundField DataField="Clientes" HeaderText="Clientes" SortExpression="Clientes" />
                    <asp:BoundField DataField="Contrato" HeaderText="Contrato" SortExpression="Contrato" />
                    <asp:BoundField DataField="Tipo Credito" HeaderText="Tipo Credito" SortExpression="Tipo Credito" />
                    <asp:TemplateField HeaderText="Monto Fianaciado" SortExpression="Monto Fianaciado">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("[Monto Fianaciado]") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("[Monto Fianaciado]", "{0:n2}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="Estatus" HeaderText="Estatus" SortExpression="Estatus" ReadOnly="True" />
                    <asp:BoundField DataField="Fecha Contrato" HeaderText="Fecha Contrato" SortExpression="Fecha Contrato" />
                    <asp:BoundField DataField="Promotor" HeaderText="Promotor" SortExpression="Promotor" />
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.ProDSTableAdapters.EstatusTRATableAdapter"></asp:ObjectDataSource>
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
