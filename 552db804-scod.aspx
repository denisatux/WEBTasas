<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="552db804-scod.aspx.vb" Inherits="WEBTasas.BitacoraForm" %>

<%@ Register Assembly="RoderoLib" Namespace="RoderoLib" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Solicitud de Documentos </title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width=100%>
    <tr>
    <td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #f58220; text-align: center">
        <br />
        Solicitud de Documentos 
        <br />
    </td>
    </tr>
        <tr>
    <td align=center>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id_Bitacora" DataSourceID="ObjectDataSource1" EnableModelValidation="True" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="Seleccionar">
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Bind("Id_Bitacora", "552db804-scod.aspx?ID={0:F0}") %>' Text='<%# Eval("Id_Bitacora", "{0:F0}") %>'></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Id_Bitacora" HeaderText="Solicitud" InsertVisible="False" ReadOnly="True" SortExpression="Id_Bitacora" Visible="False" />
                <asp:BoundField DataField="AnexoCon" HeaderText="AnexoCon" SortExpression="AnexoCon" />
                <asp:BoundField DataField="Ciclo" HeaderText="Ciclo" SortExpression="Ciclo" />
                <asp:BoundField DataField="Descr" HeaderText="Descr" SortExpression="Descr" />
                <asp:BoundField DataField="TipoCredito" HeaderText="TipoCredito" SortExpression="TipoCredito" />
                <asp:BoundField DataField="FechaSolicitud" HeaderText="FechaSolicitud" SortExpression="FechaSolicitud" />
                <asp:BoundField DataField="Solicito" HeaderText="Solicito" SortExpression="Solicito" />
                <asp:BoundField DataField="vobo" HeaderText="vobo" SortExpression="vobo" />
                <asp:CheckBoxField DataField="VoboB" SortExpression="VoboB" />
                <asp:BoundField DataField="Autoriza" HeaderText="Autoriza" SortExpression="Autoriza" />
                <asp:CheckBoxField DataField="AutorizaB" SortExpression="AutorizaB" />
            </Columns>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#f58220" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByVoboAuto" TypeName="WEBTasas.ProDSTableAdapters.BitacoraMCTableAdapter">
            <SelectParameters>
                <asp:SessionParameter Name="Solicito" SessionField="Solicita" Type="String" />
                <asp:SessionParameter Name="Vobo" SessionField="Vobo" Type="String" />
                <asp:SessionParameter Name="Autoriza" SessionField="Autoriza" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <br />
        <br />
        <asp:DetailsView AutoGenerateRows="False" CellPadding="4" DataKeyNames="Id_Bitacora" DataSourceID="vwDatos_DS" Font-Names="Verdana" Font-Size="Smaller" ForeColor="#333333" GridLines="None" HorizontalAlign="Center" ID="DetailsView1" runat="server" Width="80%" EnableModelValidation="True" >
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <RowStyle BackColor="#FFE0C0" />
            <FieldHeaderStyle BackColor="#f58220" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <Fields>
                <asp:BoundField DataField="Id_Bitacora" HeaderText="Id_Bitacora" SortExpression="Id_Bitacora" InsertVisible="False" ReadOnly="True" Visible="False" />
                <asp:BoundField DataField="AnexoCon" HeaderText="Anexo" SortExpression="AnexoCon" />
                <asp:BoundField DataField="Ciclo" HeaderText="Ciclo" SortExpression="Ciclo" />
                <asp:BoundField DataField="Descr" HeaderText="Cliente" SortExpression="Descr" />
                <asp:BoundField DataField="TipoCredito" HeaderText="TipoCredito" SortExpression="TipoCredito" />
                <asp:CheckBoxField DataField="Pagare" HeaderText="Pagare" SortExpression="Pagare" />
                <asp:CheckBoxField DataField="Contrato" HeaderText="Contrato" SortExpression="Contrato" />
                <asp:CheckBoxField DataField="Convenio" HeaderText="Convenio" SortExpression="Convenio" />
                <asp:CheckBoxField DataField="Escritura" HeaderText="Escritura" SortExpression="Escritura" />
                <asp:CheckBoxField DataField="Facturas" HeaderText="Facturas" SortExpression="Facturas" />
                <asp:CheckBoxField DataField="Garantias" HeaderText="Garantias" SortExpression="Garantias" />
                <asp:BoundField DataField="FechaSolicitud" HeaderText="FechaSolicitud"
                    SortExpression="FechaSolicitud" />
                <asp:BoundField DataField="Justificacion" HeaderText="Justificacion" SortExpression="Justificacion" />
                <asp:BoundField DataField="Solicito" HeaderText="Solicito" SortExpression="Solicito" />
                <asp:CheckBoxField DataField="AuditoriaExterna" HeaderText="AuditoriaExterna" SortExpression="AuditoriaExterna" />
                <asp:CheckBoxField DataField="NoAdeudo" HeaderText="NoAdeudo" SortExpression="NoAdeudo" />
            </Fields>
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:DetailsView>
        <asp:ObjectDataSource ID="vwDatos_DS" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="WEBTasas.ProDSTableAdapters.BitacoraMCTableAdapter">
            <SelectParameters>
                <asp:QueryStringParameter Name="ID" QueryStringField="ID" Type="Decimal" />
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
            Text="La Solicitud ya fue Autorizado"></asp:Label>
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
