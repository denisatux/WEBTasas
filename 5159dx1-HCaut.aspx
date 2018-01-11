<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="5159dx1-HCaut.aspx.vb" Inherits="WEBTasas.HC_Form1" %>

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
        Solicitud de Hoja de Cambios</td>
    </tr>
        <tr>
    <td align=center>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ObjectDataSource1" EnableModelValidation="True" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None" DataKeyNames="id_hojaCambios">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="Anexo">
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "5159dx1-HCaut.aspx?User=" & Request("User") & Eval("id_hojaCambios", "&id={0}") %>' Text='<%# Eval("AnexoCon") %>'></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Descr" HeaderText="Cliente" SortExpression="Descr" />
                <asp:BoundField DataField="TipoCredito" HeaderText="Tipo Credito" SortExpression="TipoCredito" />
                <asp:BoundField DataField="MontoFin" HeaderText="Monto Financiado" SortExpression="MontoFin" DataFormatString="{0:n2}" HtmlEncode="False" />
                <asp:BoundField DataField="id_hojaCambios" HeaderText="id_hojaCambios" SortExpression="id_hojaCambios" InsertVisible="False" ReadOnly="True" Visible="False" />
            </Columns>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData_User" TypeName="WEBTasas.ProDSTableAdapters.HojaCambiosTableAdapter">
            <SelectParameters>
                <asp:QueryStringParameter Name="User" QueryStringField="User" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <br />
        <br />
        <asp:DetailsView AutoGenerateRows="False" CellPadding="4" DataSourceID="vwDatos_DS" Font-Names="Verdana" Font-Size="Smaller" ForeColor="#333333" GridLines="None" HorizontalAlign="Center" ID="DetailsView1" runat="server" Width="80%" EnableModelValidation="True" DataKeyNames="id_hojaCambios" >
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <RowStyle BackColor="#FFE0C0" />
            <FieldHeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <Fields>
                <asp:CheckBoxField DataField="linea_credito" HeaderText="Linea de Crédito" SortExpression="linea_credito" />
                <asp:BoundField DataField="linea_condicion" HeaderText="Original" SortExpression="linea_condicion" />
                <asp:BoundField DataField="linea_cambio" HeaderText="Nueva" SortExpression="linea_cambio" />
                <asp:CheckBoxField DataField="tipo_recursos" HeaderText="Recursos" SortExpression="tipo_recursos" />
                <asp:BoundField DataField="recurso_condicion" HeaderText="Original" SortExpression="recurso_condicion" />
                <asp:BoundField DataField="recurso_cambio" HeaderText="Nueva" SortExpression="recurso_cambio" />
                <asp:CheckBoxField DataField="derechos_registro" HeaderText="Derechos" SortExpression="derechos_registro" />
                <asp:BoundField DataField="registro_condicion" HeaderText="Original" SortExpression="registro_condicion" />
                <asp:BoundField DataField="registro_cambio" HeaderText="Nueva" SortExpression="registro_cambio" />
                <asp:CheckBoxField DataField="pago_inicial" HeaderText="Pago Inicial" SortExpression="pago_inicial" />
                <asp:BoundField DataField="pago_condicion" HeaderText="Original" SortExpression="pago_condicion" />
                <asp:BoundField DataField="pago_cambio" HeaderText="Nueva" SortExpression="pago_cambio" />
                <asp:CheckBoxField DataField="plazo" HeaderText="Plazo" SortExpression="plazo" />
                <asp:BoundField DataField="plazo_condicion" HeaderText="Original" SortExpression="plazo_condicion" />
                <asp:BoundField DataField="plazo_cambio" HeaderText="Nueva" SortExpression="plazo_cambio" />
                <asp:CheckBoxField DataField="otros" HeaderText="Otros" SortExpression="otros" />
                <asp:BoundField DataField="otros_txt" HeaderText="Otros Cambios" SortExpression="otros_txt" />
                <asp:BoundField DataField="fe_cambios" HeaderText="Fecha de Solicitud" SortExpression="fe_cambios" DataFormatString="{0:D}" HtmlEncode="False" />
            </Fields>
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:DetailsView>
        <asp:ObjectDataSource ID="vwDatos_DS" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="WEBTasas.ProDSTableAdapters.MC_cambio_condicionesTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
            <DeleteParameters>
                <asp:Parameter Name="Original_id_hojaCambios" Type="Decimal" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Anexo" Type="String" />
                <asp:Parameter Name="linea_credito" Type="Boolean" />
                <asp:Parameter Name="tipo_recursos" Type="Boolean" />
                <asp:Parameter Name="derechos_registro" Type="Boolean" />
                <asp:Parameter Name="pago_inicial" Type="Boolean" />
                <asp:Parameter Name="plazo" Type="Boolean" />
                <asp:Parameter Name="otros" Type="Boolean" />
                <asp:Parameter Name="linea_condicion" Type="String" />
                <asp:Parameter Name="plazo_condicion" Type="String" />
                <asp:Parameter Name="registro_condicion" Type="String" />
                <asp:Parameter Name="recurso_condicion" Type="String" />
                <asp:Parameter Name="pago_condicion" Type="String" />
                <asp:Parameter Name="linea_cambio" Type="String" />
                <asp:Parameter Name="plazo_cambio" Type="String" />
                <asp:Parameter Name="registro_cambio" Type="String" />
                <asp:Parameter Name="recurso_cambio" Type="String" />
                <asp:Parameter Name="pago_cambio" Type="String" />
                <asp:Parameter Name="otros_txt" Type="String" />
                <asp:Parameter Name="fe_autorizacion" Type="DateTime" />
                <asp:Parameter Name="fe_cambios" Type="DateTime" />
                <asp:Parameter Name="FirmaPromo" Type="String" />
                <asp:Parameter Name="FirmaSubPromo" Type="String" />
                <asp:Parameter Name="FirmaDireccion" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="Id" QueryStringField="ID" Type="Decimal" DefaultValue="0" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Anexo" Type="String" />
                <asp:Parameter Name="linea_credito" Type="Boolean" />
                <asp:Parameter Name="tipo_recursos" Type="Boolean" />
                <asp:Parameter Name="derechos_registro" Type="Boolean" />
                <asp:Parameter Name="pago_inicial" Type="Boolean" />
                <asp:Parameter Name="plazo" Type="Boolean" />
                <asp:Parameter Name="otros" Type="Boolean" />
                <asp:Parameter Name="linea_condicion" Type="String" />
                <asp:Parameter Name="plazo_condicion" Type="String" />
                <asp:Parameter Name="registro_condicion" Type="String" />
                <asp:Parameter Name="recurso_condicion" Type="String" />
                <asp:Parameter Name="pago_condicion" Type="String" />
                <asp:Parameter Name="linea_cambio" Type="String" />
                <asp:Parameter Name="plazo_cambio" Type="String" />
                <asp:Parameter Name="registro_cambio" Type="String" />
                <asp:Parameter Name="recurso_cambio" Type="String" />
                <asp:Parameter Name="pago_cambio" Type="String" />
                <asp:Parameter Name="otros_txt" Type="String" />
                <asp:Parameter Name="fe_autorizacion" Type="DateTime" />
                <asp:Parameter Name="fe_cambios" Type="DateTime" />
                <asp:Parameter Name="FirmaPromo" Type="String" />
                <asp:Parameter Name="FirmaSubPromo" Type="String" />
                <asp:Parameter Name="FirmaDireccion" Type="String" />
                <asp:Parameter Name="Original_id_hojaCambios" Type="Decimal" />
            </UpdateParameters>
        </asp:ObjectDataSource>
    
        <asp:Panel ID="Panel1" runat="server" Height="100%" Width="100%">
            <br />
            <cc1:BotonEnviar ID="BotonEnviar1" runat="server" Font-Bold="True" Text="Autorizacion"
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
