using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using Sap.Data.Hana;

namespace TableViewer
{
    /// <summary>
    /// Summary description for Form1.
    /// </summary>
	
    public class Form1 : System.Windows.Forms.Form
    {
	private System.Windows.Forms.Label label1;
	private System.Windows.Forms.TextBox txtConnectString;
	private System.Windows.Forms.Label label2;
	private System.Windows.Forms.Button btnConnect;
	private System.Windows.Forms.TextBox txtSQLStatement;
	private System.Windows.Forms.Button btnExecute;
	private System.Windows.Forms.DataGrid dgResults;

	private HanaConnection		_conn;
	private System.Windows.Forms.Button btnClose;
	private System.Windows.Forms.Label label3;
	private System.Windows.Forms.ComboBox comboBoxTables;

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
	    this.label2 = new System.Windows.Forms.Label();
	    this.txtSQLStatement = new System.Windows.Forms.TextBox();
	    this.btnConnect = new System.Windows.Forms.Button();
	    this.btnExecute = new System.Windows.Forms.Button();
	    this.btnClose = new System.Windows.Forms.Button();
	    this.dgResults = new System.Windows.Forms.DataGrid();
	    this.label3 = new System.Windows.Forms.Label();
	    this.comboBoxTables = new System.Windows.Forms.ComboBox();
	    ((System.ComponentModel.ISupportInitialize)(this.dgResults)).BeginInit();
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
	    this.txtConnectString.Size = new System.Drawing.Size(467, 20);
	    this.txtConnectString.TabIndex = 1;
	    this.txtConnectString.Text = "Server=hana-server:30015;UserID=username;Password=passcode";
	    // 
	    // label2
	    // 
	    this.label2.Location = new System.Drawing.Point(8, 72);
	    this.label2.Name = "label2";
	    this.label2.Size = new System.Drawing.Size(88, 16);
	    this.label2.TabIndex = 4;
	    this.label2.Text = "SQL Statement:";
	    // 
	    // txtSQLStatement
	    // 
	    this.txtSQLStatement.Location = new System.Drawing.Point(8, 96);
	    this.txtSQLStatement.Multiline = true;
	    this.txtSQLStatement.Name = "txtSQLStatement";
	    this.txtSQLStatement.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
	    this.txtSQLStatement.Size = new System.Drawing.Size(684, 80);
	    this.txtSQLStatement.TabIndex = 5;
	    this.txtSQLStatement.Text = "SELECT * FROM sys.tables";
	    // 
	    // btnConnect
	    // 
	    this.btnConnect.Location = new System.Drawing.Point(617, 8);
	    this.btnConnect.Name = "btnConnect";
	    this.btnConnect.Size = new System.Drawing.Size(75, 23);
	    this.btnConnect.TabIndex = 7;
	    this.btnConnect.Text = "&Connect";
	    this.btnConnect.Click += new System.EventHandler(this.btnConnect_Click);
	    // 
	    // btnExecute
	    // 
	    this.btnExecute.Location = new System.Drawing.Point(617, 36);
	    this.btnExecute.Name = "btnExecute";
	    this.btnExecute.Size = new System.Drawing.Size(75, 23);
	    this.btnExecute.TabIndex = 8;
	    this.btnExecute.Text = "&Execute";
	    this.btnExecute.Click += new System.EventHandler(this.btnExecute_Click);
	    // 
	    // btnClose
	    // 
	    this.btnClose.DialogResult = System.Windows.Forms.DialogResult.Cancel;
	    this.btnClose.Location = new System.Drawing.Point(617, 64);
	    this.btnClose.Name = "btnClose";
	    this.btnClose.Size = new System.Drawing.Size(75, 23);
	    this.btnClose.TabIndex = 9;
	    this.btnClose.Text = "C&lose";
	    this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
	    // 
	    // dgResults
	    // 
	    this.dgResults.CaptionText = "Results";
	    this.dgResults.DataMember = "";
	    this.dgResults.HeaderForeColor = System.Drawing.SystemColors.ControlText;
	    this.dgResults.Location = new System.Drawing.Point(8, 184);
	    this.dgResults.Name = "dgResults";
	    this.dgResults.ReadOnly = true;
	    this.dgResults.Size = new System.Drawing.Size(684, 320);
	    this.dgResults.TabIndex = 6;
	    // 
	    // label3
	    // 
	    this.label3.Location = new System.Drawing.Point(492, 8);
	    this.label3.Name = "label3";
	    this.label3.Size = new System.Drawing.Size(40, 16);
	    this.label3.TabIndex = 2;
	    this.label3.Text = "Tables:";
	    // 
	    // comboBoxTables
	    // 
	    this.comboBoxTables.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
	    this.comboBoxTables.Location = new System.Drawing.Point(492, 32);
	    this.comboBoxTables.Name = "comboBoxTables";
	    this.comboBoxTables.Size = new System.Drawing.Size(112, 21);
	    this.comboBoxTables.Sorted = true;
	    this.comboBoxTables.TabIndex = 3;
	    this.comboBoxTables.SelectedIndexChanged += new System.EventHandler(this.comboBoxTables_SelectedIndexChanged);
	    // 
	    // Form1
	    // 
	    this.AcceptButton = this.btnExecute;
	    this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
	    this.CancelButton = this.btnClose;
	    this.ClientSize = new System.Drawing.Size(703, 510);
	    this.Controls.Add(this.comboBoxTables);
	    this.Controls.Add(this.label3);
	    this.Controls.Add(this.btnClose);
	    this.Controls.Add(this.dgResults);
	    this.Controls.Add(this.btnExecute);
	    this.Controls.Add(this.btnConnect);
	    this.Controls.Add(this.txtSQLStatement);
	    this.Controls.Add(this.txtConnectString);
	    this.Controls.Add(this.label2);
	    this.Controls.Add(this.label1);
	    this.Name = "Form1";
	    this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
	    this.Text = "Table Viewer";
	    ((System.ComponentModel.ISupportInitialize)(this.dgResults)).EndInit();
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
	    try 
	    {
		_conn = new HanaConnection( txtConnectString.Text );
		_conn.Open();
	
		HanaCommand      cmd = new HanaCommand( "SELECT schema_name,table_name FROM sys.tables", _conn );
		HanaDataReader   dr = cmd.ExecuteReader();
                
		comboBoxTables.Items.Clear();  
		while ( dr.Read() ) 
		{
		    comboBoxTables.Items.Add( dr.GetString( 0 ) + '.' + dr.GetString( 1 ) );
		}
		dr.Close();
	    } 
	    catch( HanaException ex ) 
	    {
                MessageBox.Show( ex.Errors[0].Source + " : " + ex.Errors[0].Message + " (" + 
				 ex.Errors[0].NativeError.ToString() + ")",
				 "Failed to initialize" );
	    }
		catch ( TypeInitializationException ex )
		{
		MessageBox.Show( ex.InnerException.Source + " : " + ex.InnerException.Message,
				 "Failed to load HANA ADO.NET Provider, can't find native DLL" );
		}
		
	}

	private void btnExecute_Click(object sender, System.EventArgs e) 
	{
	
	    if( _conn == null || _conn.State != ConnectionState.Open ) 
	    {
		MessageBox.Show( "Connect to a database first.", "Not connected" );
		return;
	    }
	    if( txtSQLStatement.Text.Trim().Length < 1 ) 
	    {
		MessageBox.Show( "Please enter the command text.", "Empty command text" );
		txtSQLStatement.SelectAll();
		txtSQLStatement.Focus(); 
		return;
	    }

	    try 
	    {
		dgResults.DataSource = null;
			    
		HanaCommand      cmd = new HanaCommand( txtSQLStatement.Text.Trim(), _conn );
		HanaDataReader   dr = cmd.ExecuteReader();
			    
		if ( dr != null )
		{
		    dgResults.DataSource = dr;
		    dr.Close();
		} 
	    } 
	    catch( HanaException ex ) 
	    {
		MessageBox.Show( ex.Errors[0].Source + " : " + ex.Errors[0].Message + " (" + 
		    ex.Errors[0].NativeError.ToString() + ")",
		    "Failed to execute SQL statement" );
	    }
	    
	    txtSQLStatement.SelectAll();
	    txtSQLStatement.Focus(); 
	}

	private void btnClose_Click(object sender, System.EventArgs e)
	{
	    this.Close(); 
	}

        private void comboBoxTables_SelectedIndexChanged(object sender, EventArgs e)
	{
	    txtSQLStatement.Text = "SELECT * FROM " + comboBoxTables.SelectedItem.ToString();
	}
		    	
    }
}
