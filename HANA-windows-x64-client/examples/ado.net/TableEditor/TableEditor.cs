using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using Sap.Data.Hana;

namespace TableEditor
{
    /// <summary>
    /// Summary description for Form1.
    /// </summary>
	
    public class Form1 : System.Windows.Forms.Form
    {
	private System.Windows.Forms.Label label1;
	private System.Windows.Forms.TextBox txtConnectString;
	private System.Windows.Forms.Button btnConnect;
	private System.Windows.Forms.Button btnUpdate;
	private System.Windows.Forms.Button btnCancel;
	private DataGridView dataGridViewProducts;

	private HanaConnection		_conn;
	private HanaDataAdapter		_da;
	private DataTable		_dataTable;
	private HanaParameter		_parm1;
	private HanaParameter		_parm2;
	private int			_errors = 0;

	/// <summary>
	/// Required designer variable.
	/// </summary>
	private System.ComponentModel.Container components = null;

	public Form1()
	{
	    //
	    // Required for Windows Form Designer support
	    //
	    InitializeComponent();

	    //
	    // TODO: Add any constructor code after InitializeComponent call
	    //
	}

	/// <summary>
	/// Clean up any resources being used.
	/// </summary>
	protected override void Dispose( bool disposing )
	{	
	    if( _conn != null && _conn.State == ConnectionState.Open ) 
	    {
		_conn.Close();
	    }
	    if( disposing )
	    {
		if (components != null) 
		{
		    components.Dispose();
		}	
	    }	
	    base.Dispose( disposing );
	}

	#region Windows Form Designer generated code
	/// <summary>
	/// Required method for Designer support - do not modify
	/// the contents of this method with the code editor.
	/// </summary>
	private void InitializeComponent()
	{
	    this.label1 = new System.Windows.Forms.Label();
	    this.txtConnectString = new System.Windows.Forms.TextBox();
	    this.btnConnect = new System.Windows.Forms.Button();
	    this.btnUpdate = new System.Windows.Forms.Button();
	    this.btnCancel = new System.Windows.Forms.Button();
	    this.dataGridViewProducts = new System.Windows.Forms.DataGridView();
	    ((System.ComponentModel.ISupportInitialize)(this.dataGridViewProducts)).BeginInit();
	    this.SuspendLayout();
	    // 
	    // label1
	    // 
	    this.label1.Location = new System.Drawing.Point(8, 8);
	    this.label1.Name = "label1";
	    this.label1.Size = new System.Drawing.Size(168, 16);
	    this.label1.TabIndex = 0;
	    this.label1.Text = "Connection String:";
	    // 
	    // txtConnectString
	    // 
	    this.txtConnectString.Location = new System.Drawing.Point(8, 32);
	    this.txtConnectString.Name = "txtConnectString";
	    this.txtConnectString.Size = new System.Drawing.Size(643, 20);
	    this.txtConnectString.TabIndex = 1;
	    this.txtConnectString.Text = "Server=hana-server:30015;UserID=username;Password=passcode";
	    // 
	    // btnConnect
	    // 
	    this.btnConnect.Location = new System.Drawing.Point(660, 30);
	    this.btnConnect.Name = "btnConnect";
	    this.btnConnect.Size = new System.Drawing.Size(75, 23);
	    this.btnConnect.TabIndex = 7;
	    this.btnConnect.Text = "&Connect";
	    this.btnConnect.Click += new System.EventHandler(this.btnConnect_Click);
	    // 
	    // btnUpdate
	    // 
	    this.btnUpdate.Location = new System.Drawing.Point(741, 29);
	    this.btnUpdate.Name = "btnUpdate";
	    this.btnUpdate.Size = new System.Drawing.Size(75, 23);
	    this.btnUpdate.TabIndex = 8;
	    this.btnUpdate.Text = "&Update";
	    this.btnUpdate.Click += new System.EventHandler(this.btnUpdate_Click);
	    // 
	    // btnCancel
	    // 
	    this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
	    this.btnCancel.Location = new System.Drawing.Point(822, 30);
	    this.btnCancel.Name = "btnCancel";
	    this.btnCancel.Size = new System.Drawing.Size(75, 23);
	    this.btnCancel.TabIndex = 9;
	    this.btnCancel.Text = "C&ancel";
	    this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
	    // 
	    // dataGridViewProducts
	    // 
	    this.dataGridViewProducts.AllowUserToAddRows = false;
	    this.dataGridViewProducts.AllowUserToDeleteRows = false;
	    this.dataGridViewProducts.AllowUserToOrderColumns = true;
	    this.dataGridViewProducts.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
	    this.dataGridViewProducts.Location = new System.Drawing.Point(13, 59);
	    this.dataGridViewProducts.Name = "dataGridViewProducts";
	    this.dataGridViewProducts.Size = new System.Drawing.Size(886, 291);
	    this.dataGridViewProducts.TabIndex = 10;
	    this.dataGridViewProducts.DataError += new System.Windows.Forms.DataGridViewDataErrorEventHandler(this.dataGridViewProducts_DataError);
	    // 
	    // Form1
	    // 
	    this.AcceptButton = this.btnConnect;
	    this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
	    this.CancelButton = this.btnCancel;
	    this.ClientSize = new System.Drawing.Size(911, 362);
	    this.Controls.Add(this.dataGridViewProducts);
	    this.Controls.Add(this.btnCancel);
	    this.Controls.Add(this.btnUpdate);
	    this.Controls.Add(this.btnConnect);
	    this.Controls.Add(this.txtConnectString);
	    this.Controls.Add(this.label1);
	    this.Name = "Form1";
	    this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
	    this.Text = "Table Editor";
	    ((System.ComponentModel.ISupportInitialize)(this.dataGridViewProducts)).EndInit();
	    this.ResumeLayout(false);
	    this.PerformLayout();

	}
	#endregion

	/// <summary>
	/// The main entry point for the application.
	/// </summary>
	[STAThread]
	static void Main() 
	{
	    Application.Run(new Form1());
	}

	private void btnConnect_Click(object sender, System.EventArgs e) 
	{
	    if (_conn != null && _conn.State == ConnectionState.Open)
	    {
		MessageBox.Show("Already connnected to server", "Connected");
		return;
	    }
	    try 
	    {
		_conn = new HanaConnection(txtConnectString.Text);
		_conn.Open();

		_da = new HanaDataAdapter();
		_da.MissingMappingAction = MissingMappingAction.Passthrough;
		_da.MissingSchemaAction = MissingSchemaAction.Add;

		_da.SelectCommand = new HanaCommand(
		    "SELECT * FROM Demo.Products ORDER BY ID", _conn);

		_da.UpdateCommand = new HanaCommand();
		_da.UpdateCommand.Connection = _conn;
		_da.UpdateCommand.UpdatedRowSource = UpdateRowSource.None;

		_dataTable = new DataTable("Products");
		int rowCount = _da.Fill(_dataTable);

		dataGridViewProducts.DataSource = _dataTable;
		dataGridViewProducts.Columns[0].ReadOnly = true;

		String updateSqlStatement = "UPDATE Demo.Products SET ";
		foreach (DataColumn dtcolumn in _dataTable.Columns)
		{
		    String upperColumnName = dtcolumn.ColumnName.ToUpper();
		    // ID: Don't update the primary key column (it is a foreign key)
		    // Photo: Don't update the binary photo column (needs special handling)
		    if (upperColumnName != "ID" && upperColumnName != "PHOTO")
		    {
			_parm1 = new HanaParameter();
			_parm1.SourceVersion = DataRowVersion.Current;
			_parm1.HanaDbType = HanaDbType.VarChar;
			_parm1.SourceColumn = dtcolumn.ColumnName;
			_parm1.SourceVersion = DataRowVersion.Current;
			_da.UpdateCommand.Parameters.Add(_parm1);
			updateSqlStatement += dtcolumn.ColumnName + " = ?, ";
		    }
		}
		char[] charsToTrim = { ',', ' ' };
		updateSqlStatement = updateSqlStatement.Trim(charsToTrim);
		updateSqlStatement += " WHERE ID = ?";
		_da.UpdateCommand.CommandText = updateSqlStatement;

		_parm2 = new HanaParameter();
		_parm2.HanaDbType = HanaDbType.Integer;
		_parm2.SourceColumn = "ID";
		_parm2.SourceVersion = DataRowVersion.Original;
		_da.UpdateCommand.Parameters.Add(_parm2);
	    }
	    catch (HanaException ex)
	    {
		MessageBox.Show(ex.Errors[0].Source + " : " + ex.Errors[0].Message + " (" +
				 ex.Errors[0].NativeError.ToString() + ")",
				 "Failed to initialize");
	    }	
		catch ( TypeInitializationException ex )
		{
			MessageBox.Show( ex.InnerException.Source + " : " + ex.InnerException.Message,
				 "Failed to load HANA ADO.NET Provider, can't find native DLL" );
		}
	}

	private void btnUpdate_Click(object sender, System.EventArgs e) 
	{
	    if (_conn == null || _conn.State != ConnectionState.Open)
	    {
		MessageBox.Show("Connect to a database first.", "Not connected");
		return;
	    }
	    try
	    {
		int rowCount = _da.Update(_dataTable);
	    }
	    catch (HanaException ex)
	    {
		MessageBox.Show(ex.Errors[0].Source + " : " + ex.Errors[0].Message + " (" +
				 ex.Errors[0].NativeError.ToString() + ")",
				 "Failed to update");
	    }
	}

	private void btnCancel_Click(object sender, System.EventArgs e)
	{
	    if (_conn == null || _conn.State != ConnectionState.Open)
	    {
		MessageBox.Show("Connect to a database first.", "Not connected");
		return;
	    }
	    try
	    {
		_dataTable.Clear();
		int rowCount = _da.Fill(_dataTable);
	    }
	    catch (HanaException ex)
	    {
		MessageBox.Show(ex.Errors[0].Source + " : " + ex.Errors[0].Message + " (" +
				 ex.Errors[0].NativeError.ToString() + ")",
				 "Failed to cancel");
	    }
	}

	private void dataGridViewProducts_DataError(object sender, DataGridViewDataErrorEventArgs e)
	{
	    // Stop datagrid from popping up errors for each photo cell
	    _errors++;
	}

    }
}
