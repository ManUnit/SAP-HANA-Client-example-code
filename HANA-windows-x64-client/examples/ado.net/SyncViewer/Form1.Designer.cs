namespace SyncViewer
{
    partial class Form1
    {
	/// <summary>
	/// Required designer variable.
	/// </summary>
	private System.ComponentModel.IContainer components = null;

	/// <summary>
	/// Clean up any resources being used.
	/// </summary>
	/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
	protected override void Dispose(bool disposing)
	{
	    if (disposing && (components != null))
	    {
		components.Dispose();
	    }
	    base.Dispose(disposing);
	}

	#region Windows Form Designer generated code

	/// <summary>
	/// Required method for Designer support - do not modify
	/// the contents of this method with the code editor.
	/// </summary>
	private void InitializeComponent()
	{
	    this.components = new System.ComponentModel.Container();
	    System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
	    System.Windows.Forms.Label iDLabel;
	    System.Windows.Forms.Label nAMELabel;
	    System.Windows.Forms.Label dESCRIPTIONLabel;
	    System.Windows.Forms.Label sIZELabel;
	    System.Windows.Forms.Label cOLORLabel;
	    System.Windows.Forms.Label qUANTITYLabel;
	    System.Windows.Forms.Label uNITPRICELabel;
	    System.Windows.Forms.Label pHOTOLabel;
	    this.pRODUCTSBindingNavigator = new System.Windows.Forms.BindingNavigator(this.components);
	    this.bindingNavigatorMoveFirstItem = new System.Windows.Forms.ToolStripButton();
	    this.bindingNavigatorMovePreviousItem = new System.Windows.Forms.ToolStripButton();
	    this.bindingNavigatorSeparator = new System.Windows.Forms.ToolStripSeparator();
	    this.bindingNavigatorPositionItem = new System.Windows.Forms.ToolStripTextBox();
	    this.bindingNavigatorCountItem = new System.Windows.Forms.ToolStripLabel();
	    this.bindingNavigatorSeparator1 = new System.Windows.Forms.ToolStripSeparator();
	    this.bindingNavigatorMoveNextItem = new System.Windows.Forms.ToolStripButton();
	    this.bindingNavigatorMoveLastItem = new System.Windows.Forms.ToolStripButton();
	    this.bindingNavigatorSeparator2 = new System.Windows.Forms.ToolStripSeparator();
	    this.bindingNavigatorAddNewItem = new System.Windows.Forms.ToolStripButton();
	    this.bindingNavigatorDeleteItem = new System.Windows.Forms.ToolStripButton();
	    this.pRODUCTSBindingNavigatorSaveItem = new System.Windows.Forms.ToolStripButton();
	    this.iDTextBox = new System.Windows.Forms.TextBox();
	    this.nAMETextBox = new System.Windows.Forms.TextBox();
	    this.dESCRIPTIONTextBox = new System.Windows.Forms.TextBox();
	    this.sIZETextBox = new System.Windows.Forms.TextBox();
	    this.cOLORTextBox = new System.Windows.Forms.TextBox();
	    this.qUANTITYTextBox = new System.Windows.Forms.TextBox();
	    this.uNITPRICETextBox = new System.Windows.Forms.TextBox();
	    this.pHOTOPictureBox = new System.Windows.Forms.PictureBox();
	    this.pRODUCTSBindingSource = new System.Windows.Forms.BindingSource(this.components);
	    this.dataSet1 = new SyncViewer.DataSet1();
	    this.pRODUCTSTableAdapter = new SyncViewer.DataSet1TableAdapters.PRODUCTSTableAdapter();
	    this.tableAdapterManager = new SyncViewer.DataSet1TableAdapters.TableAdapterManager();
	    this.vIEWSALESORDERSBindingSource = new System.Windows.Forms.BindingSource(this.components);
	    this.vIEWSALESORDERSTableAdapter = new SyncViewer.DataSet1TableAdapters.VIEWSALESORDERSTableAdapter();
	    this.vIEWSALESORDERSDataGridView = new System.Windows.Forms.DataGridView();
	    this.dataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
	    this.dataGridViewTextBoxColumn2 = new System.Windows.Forms.DataGridViewTextBoxColumn();
	    iDLabel = new System.Windows.Forms.Label();
	    nAMELabel = new System.Windows.Forms.Label();
	    dESCRIPTIONLabel = new System.Windows.Forms.Label();
	    sIZELabel = new System.Windows.Forms.Label();
	    cOLORLabel = new System.Windows.Forms.Label();
	    qUANTITYLabel = new System.Windows.Forms.Label();
	    uNITPRICELabel = new System.Windows.Forms.Label();
	    pHOTOLabel = new System.Windows.Forms.Label();
	    ((System.ComponentModel.ISupportInitialize)(this.pRODUCTSBindingNavigator)).BeginInit();
	    this.pRODUCTSBindingNavigator.SuspendLayout();
	    ((System.ComponentModel.ISupportInitialize)(this.pHOTOPictureBox)).BeginInit();
	    ((System.ComponentModel.ISupportInitialize)(this.pRODUCTSBindingSource)).BeginInit();
	    ((System.ComponentModel.ISupportInitialize)(this.dataSet1)).BeginInit();
	    ((System.ComponentModel.ISupportInitialize)(this.vIEWSALESORDERSBindingSource)).BeginInit();
	    ((System.ComponentModel.ISupportInitialize)(this.vIEWSALESORDERSDataGridView)).BeginInit();
	    this.SuspendLayout();
	    // 
	    // pRODUCTSBindingNavigator
	    // 
	    this.pRODUCTSBindingNavigator.AddNewItem = this.bindingNavigatorAddNewItem;
	    this.pRODUCTSBindingNavigator.BindingSource = this.pRODUCTSBindingSource;
	    this.pRODUCTSBindingNavigator.CountItem = this.bindingNavigatorCountItem;
	    this.pRODUCTSBindingNavigator.DeleteItem = this.bindingNavigatorDeleteItem;
	    this.pRODUCTSBindingNavigator.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.bindingNavigatorMoveFirstItem,
            this.bindingNavigatorMovePreviousItem,
            this.bindingNavigatorSeparator,
            this.bindingNavigatorPositionItem,
            this.bindingNavigatorCountItem,
            this.bindingNavigatorSeparator1,
            this.bindingNavigatorMoveNextItem,
            this.bindingNavigatorMoveLastItem,
            this.bindingNavigatorSeparator2,
            this.bindingNavigatorAddNewItem,
            this.bindingNavigatorDeleteItem,
            this.pRODUCTSBindingNavigatorSaveItem});
	    this.pRODUCTSBindingNavigator.Location = new System.Drawing.Point(0, 0);
	    this.pRODUCTSBindingNavigator.MoveFirstItem = this.bindingNavigatorMoveFirstItem;
	    this.pRODUCTSBindingNavigator.MoveLastItem = this.bindingNavigatorMoveLastItem;
	    this.pRODUCTSBindingNavigator.MoveNextItem = this.bindingNavigatorMoveNextItem;
	    this.pRODUCTSBindingNavigator.MovePreviousItem = this.bindingNavigatorMovePreviousItem;
	    this.pRODUCTSBindingNavigator.Name = "pRODUCTSBindingNavigator";
	    this.pRODUCTSBindingNavigator.PositionItem = this.bindingNavigatorPositionItem;
	    this.pRODUCTSBindingNavigator.Size = new System.Drawing.Size(569, 25);
	    this.pRODUCTSBindingNavigator.TabIndex = 0;
	    this.pRODUCTSBindingNavigator.Text = "bindingNavigator1";
	    // 
	    // bindingNavigatorMoveFirstItem
	    // 
	    this.bindingNavigatorMoveFirstItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
	    this.bindingNavigatorMoveFirstItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMoveFirstItem.Image")));
	    this.bindingNavigatorMoveFirstItem.Name = "bindingNavigatorMoveFirstItem";
	    this.bindingNavigatorMoveFirstItem.RightToLeftAutoMirrorImage = true;
	    this.bindingNavigatorMoveFirstItem.Size = new System.Drawing.Size(23, 22);
	    this.bindingNavigatorMoveFirstItem.Text = "Move first";
	    // 
	    // bindingNavigatorMovePreviousItem
	    // 
	    this.bindingNavigatorMovePreviousItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
	    this.bindingNavigatorMovePreviousItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMovePreviousItem.Image")));
	    this.bindingNavigatorMovePreviousItem.Name = "bindingNavigatorMovePreviousItem";
	    this.bindingNavigatorMovePreviousItem.RightToLeftAutoMirrorImage = true;
	    this.bindingNavigatorMovePreviousItem.Size = new System.Drawing.Size(23, 22);
	    this.bindingNavigatorMovePreviousItem.Text = "Move previous";
	    // 
	    // bindingNavigatorSeparator
	    // 
	    this.bindingNavigatorSeparator.Name = "bindingNavigatorSeparator";
	    this.bindingNavigatorSeparator.Size = new System.Drawing.Size(6, 25);
	    // 
	    // bindingNavigatorPositionItem
	    // 
	    this.bindingNavigatorPositionItem.AccessibleName = "Position";
	    this.bindingNavigatorPositionItem.AutoSize = false;
	    this.bindingNavigatorPositionItem.Name = "bindingNavigatorPositionItem";
	    this.bindingNavigatorPositionItem.Size = new System.Drawing.Size(50, 23);
	    this.bindingNavigatorPositionItem.Text = "0";
	    this.bindingNavigatorPositionItem.ToolTipText = "Current position";
	    // 
	    // bindingNavigatorCountItem
	    // 
	    this.bindingNavigatorCountItem.Name = "bindingNavigatorCountItem";
	    this.bindingNavigatorCountItem.Size = new System.Drawing.Size(35, 22);
	    this.bindingNavigatorCountItem.Text = "of {0}";
	    this.bindingNavigatorCountItem.ToolTipText = "Total number of items";
	    // 
	    // bindingNavigatorSeparator1
	    // 
	    this.bindingNavigatorSeparator1.Name = "bindingNavigatorSeparator";
	    this.bindingNavigatorSeparator1.Size = new System.Drawing.Size(6, 25);
	    // 
	    // bindingNavigatorMoveNextItem
	    // 
	    this.bindingNavigatorMoveNextItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
	    this.bindingNavigatorMoveNextItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMoveNextItem.Image")));
	    this.bindingNavigatorMoveNextItem.Name = "bindingNavigatorMoveNextItem";
	    this.bindingNavigatorMoveNextItem.RightToLeftAutoMirrorImage = true;
	    this.bindingNavigatorMoveNextItem.Size = new System.Drawing.Size(23, 22);
	    this.bindingNavigatorMoveNextItem.Text = "Move next";
	    // 
	    // bindingNavigatorMoveLastItem
	    // 
	    this.bindingNavigatorMoveLastItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
	    this.bindingNavigatorMoveLastItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMoveLastItem.Image")));
	    this.bindingNavigatorMoveLastItem.Name = "bindingNavigatorMoveLastItem";
	    this.bindingNavigatorMoveLastItem.RightToLeftAutoMirrorImage = true;
	    this.bindingNavigatorMoveLastItem.Size = new System.Drawing.Size(23, 22);
	    this.bindingNavigatorMoveLastItem.Text = "Move last";
	    // 
	    // bindingNavigatorSeparator2
	    // 
	    this.bindingNavigatorSeparator2.Name = "bindingNavigatorSeparator";
	    this.bindingNavigatorSeparator2.Size = new System.Drawing.Size(6, 25);
	    // 
	    // bindingNavigatorAddNewItem
	    // 
	    this.bindingNavigatorAddNewItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
	    this.bindingNavigatorAddNewItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorAddNewItem.Image")));
	    this.bindingNavigatorAddNewItem.Name = "bindingNavigatorAddNewItem";
	    this.bindingNavigatorAddNewItem.RightToLeftAutoMirrorImage = true;
	    this.bindingNavigatorAddNewItem.Size = new System.Drawing.Size(23, 22);
	    this.bindingNavigatorAddNewItem.Text = "Add new";
	    // 
	    // bindingNavigatorDeleteItem
	    // 
	    this.bindingNavigatorDeleteItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
	    this.bindingNavigatorDeleteItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorDeleteItem.Image")));
	    this.bindingNavigatorDeleteItem.Name = "bindingNavigatorDeleteItem";
	    this.bindingNavigatorDeleteItem.RightToLeftAutoMirrorImage = true;
	    this.bindingNavigatorDeleteItem.Size = new System.Drawing.Size(23, 22);
	    this.bindingNavigatorDeleteItem.Text = "Delete";
	    // 
	    // pRODUCTSBindingNavigatorSaveItem
	    // 
	    this.pRODUCTSBindingNavigatorSaveItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
	    this.pRODUCTSBindingNavigatorSaveItem.Image = ((System.Drawing.Image)(resources.GetObject("pRODUCTSBindingNavigatorSaveItem.Image")));
	    this.pRODUCTSBindingNavigatorSaveItem.Name = "pRODUCTSBindingNavigatorSaveItem";
	    this.pRODUCTSBindingNavigatorSaveItem.Size = new System.Drawing.Size(23, 22);
	    this.pRODUCTSBindingNavigatorSaveItem.Text = "Save Data";
	    this.pRODUCTSBindingNavigatorSaveItem.Click += new System.EventHandler(this.pRODUCTSBindingNavigatorSaveItem_Click);
	    // 
	    // iDLabel
	    // 
	    iDLabel.AutoSize = true;
	    iDLabel.Location = new System.Drawing.Point(25, 59);
	    iDLabel.Name = "iDLabel";
	    iDLabel.Size = new System.Drawing.Size(21, 13);
	    iDLabel.TabIndex = 1;
	    iDLabel.Text = "ID:";
	    // 
	    // iDTextBox
	    // 
	    this.iDTextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.pRODUCTSBindingSource, "ID", true));
	    this.iDTextBox.Location = new System.Drawing.Point(114, 56);
	    this.iDTextBox.Name = "iDTextBox";
	    this.iDTextBox.Size = new System.Drawing.Size(100, 20);
	    this.iDTextBox.TabIndex = 2;
	    this.iDTextBox.TextChanged += new System.EventHandler(this.fillToolStripButton_Click);
	    // 
	    // nAMELabel
	    // 
	    nAMELabel.AutoSize = true;
	    nAMELabel.Location = new System.Drawing.Point(25, 85);
	    nAMELabel.Name = "nAMELabel";
	    nAMELabel.Size = new System.Drawing.Size(41, 13);
	    nAMELabel.TabIndex = 3;
	    nAMELabel.Text = "NAME:";
	    // 
	    // nAMETextBox
	    // 
	    this.nAMETextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.pRODUCTSBindingSource, "NAME", true));
	    this.nAMETextBox.Location = new System.Drawing.Point(114, 82);
	    this.nAMETextBox.Name = "nAMETextBox";
	    this.nAMETextBox.Size = new System.Drawing.Size(100, 20);
	    this.nAMETextBox.TabIndex = 4;
	    // 
	    // dESCRIPTIONLabel
	    // 
	    dESCRIPTIONLabel.AutoSize = true;
	    dESCRIPTIONLabel.Location = new System.Drawing.Point(25, 111);
	    dESCRIPTIONLabel.Name = "dESCRIPTIONLabel";
	    dESCRIPTIONLabel.Size = new System.Drawing.Size(83, 13);
	    dESCRIPTIONLabel.TabIndex = 5;
	    dESCRIPTIONLabel.Text = "DESCRIPTION:";
	    // 
	    // dESCRIPTIONTextBox
	    // 
	    this.dESCRIPTIONTextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.pRODUCTSBindingSource, "DESCRIPTION", true));
	    this.dESCRIPTIONTextBox.Location = new System.Drawing.Point(114, 108);
	    this.dESCRIPTIONTextBox.Name = "dESCRIPTIONTextBox";
	    this.dESCRIPTIONTextBox.Size = new System.Drawing.Size(100, 20);
	    this.dESCRIPTIONTextBox.TabIndex = 6;
	    // 
	    // sIZELabel
	    // 
	    sIZELabel.AutoSize = true;
	    sIZELabel.Location = new System.Drawing.Point(25, 137);
	    sIZELabel.Name = "sIZELabel";
	    sIZELabel.Size = new System.Drawing.Size(34, 13);
	    sIZELabel.TabIndex = 7;
	    sIZELabel.Text = "SIZE:";
	    // 
	    // sIZETextBox
	    // 
	    this.sIZETextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.pRODUCTSBindingSource, "SIZE", true));
	    this.sIZETextBox.Location = new System.Drawing.Point(114, 134);
	    this.sIZETextBox.Name = "sIZETextBox";
	    this.sIZETextBox.Size = new System.Drawing.Size(100, 20);
	    this.sIZETextBox.TabIndex = 8;
	    // 
	    // cOLORLabel
	    // 
	    cOLORLabel.AutoSize = true;
	    cOLORLabel.Location = new System.Drawing.Point(25, 163);
	    cOLORLabel.Name = "cOLORLabel";
	    cOLORLabel.Size = new System.Drawing.Size(47, 13);
	    cOLORLabel.TabIndex = 9;
	    cOLORLabel.Text = "COLOR:";
	    // 
	    // cOLORTextBox
	    // 
	    this.cOLORTextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.pRODUCTSBindingSource, "COLOR", true));
	    this.cOLORTextBox.Location = new System.Drawing.Point(114, 160);
	    this.cOLORTextBox.Name = "cOLORTextBox";
	    this.cOLORTextBox.Size = new System.Drawing.Size(100, 20);
	    this.cOLORTextBox.TabIndex = 10;
	    // 
	    // qUANTITYLabel
	    // 
	    qUANTITYLabel.AutoSize = true;
	    qUANTITYLabel.Location = new System.Drawing.Point(25, 189);
	    qUANTITYLabel.Name = "qUANTITYLabel";
	    qUANTITYLabel.Size = new System.Drawing.Size(65, 13);
	    qUANTITYLabel.TabIndex = 11;
	    qUANTITYLabel.Text = "QUANTITY:";
	    // 
	    // qUANTITYTextBox
	    // 
	    this.qUANTITYTextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.pRODUCTSBindingSource, "QUANTITY", true));
	    this.qUANTITYTextBox.Location = new System.Drawing.Point(114, 186);
	    this.qUANTITYTextBox.Name = "qUANTITYTextBox";
	    this.qUANTITYTextBox.Size = new System.Drawing.Size(100, 20);
	    this.qUANTITYTextBox.TabIndex = 12;
	    // 
	    // uNITPRICELabel
	    // 
	    uNITPRICELabel.AutoSize = true;
	    uNITPRICELabel.Location = new System.Drawing.Point(25, 215);
	    uNITPRICELabel.Name = "uNITPRICELabel";
	    uNITPRICELabel.Size = new System.Drawing.Size(68, 13);
	    uNITPRICELabel.TabIndex = 13;
	    uNITPRICELabel.Text = "UNITPRICE:";
	    // 
	    // uNITPRICETextBox
	    // 
	    this.uNITPRICETextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.pRODUCTSBindingSource, "UNITPRICE", true));
	    this.uNITPRICETextBox.Location = new System.Drawing.Point(114, 212);
	    this.uNITPRICETextBox.Name = "uNITPRICETextBox";
	    this.uNITPRICETextBox.Size = new System.Drawing.Size(100, 20);
	    this.uNITPRICETextBox.TabIndex = 14;
	    // 
	    // pHOTOLabel
	    // 
	    pHOTOLabel.AutoSize = true;
	    pHOTOLabel.Location = new System.Drawing.Point(25, 238);
	    pHOTOLabel.Name = "pHOTOLabel";
	    pHOTOLabel.Size = new System.Drawing.Size(48, 13);
	    pHOTOLabel.TabIndex = 15;
	    pHOTOLabel.Text = "PHOTO:";
	    // 
	    // pHOTOPictureBox
	    // 
	    this.pHOTOPictureBox.DataBindings.Add(new System.Windows.Forms.Binding("Image", this.pRODUCTSBindingSource, "PHOTO", true));
	    this.pHOTOPictureBox.Location = new System.Drawing.Point(114, 238);
	    this.pHOTOPictureBox.Name = "pHOTOPictureBox";
	    this.pHOTOPictureBox.Size = new System.Drawing.Size(100, 104);
	    this.pHOTOPictureBox.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
	    this.pHOTOPictureBox.TabIndex = 16;
	    this.pHOTOPictureBox.TabStop = false;
	    // 
	    // pRODUCTSBindingSource
	    // 
	    this.pRODUCTSBindingSource.DataMember = "PRODUCTS";
	    this.pRODUCTSBindingSource.DataSource = this.dataSet1;
	    // 
	    // dataSet1
	    // 
	    this.dataSet1.DataSetName = "DataSet1";
	    this.dataSet1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
	    // 
	    // pRODUCTSTableAdapter
	    // 
	    this.pRODUCTSTableAdapter.ClearBeforeFill = true;
	    // 
	    // tableAdapterManager
	    // 
	    this.tableAdapterManager.BackupDataSetBeforeUpdate = false;
	    this.tableAdapterManager.PRODUCTSTableAdapter = this.pRODUCTSTableAdapter;
	    this.tableAdapterManager.UpdateOrder = SyncViewer.DataSet1TableAdapters.TableAdapterManager.UpdateOrderOption.InsertUpdateDelete;
	    // 
	    // vIEWSALESORDERSBindingSource
	    // 
	    this.vIEWSALESORDERSBindingSource.DataMember = "VIEWSALESORDERS";
	    this.vIEWSALESORDERSBindingSource.DataSource = this.dataSet1;
	    // 
	    // vIEWSALESORDERSTableAdapter
	    // 
	    this.vIEWSALESORDERSTableAdapter.ClearBeforeFill = true;
	    // 
	    // vIEWSALESORDERSDataGridView
	    // 
	    this.vIEWSALESORDERSDataGridView.AutoGenerateColumns = false;
	    this.vIEWSALESORDERSDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
	    this.vIEWSALESORDERSDataGridView.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.dataGridViewTextBoxColumn1,
            this.dataGridViewTextBoxColumn2});
	    this.vIEWSALESORDERSDataGridView.DataSource = this.vIEWSALESORDERSBindingSource;
	    this.vIEWSALESORDERSDataGridView.Location = new System.Drawing.Point(234, 56);
	    this.vIEWSALESORDERSDataGridView.Name = "vIEWSALESORDERSDataGridView";
	    this.vIEWSALESORDERSDataGridView.Size = new System.Drawing.Size(300, 220);
	    this.vIEWSALESORDERSDataGridView.TabIndex = 18;
	    // 
	    // dataGridViewTextBoxColumn1
	    // 
	    this.dataGridViewTextBoxColumn1.DataPropertyName = "REGION";
	    this.dataGridViewTextBoxColumn1.HeaderText = "REGION";
	    this.dataGridViewTextBoxColumn1.Name = "dataGridViewTextBoxColumn1";
	    // 
	    // dataGridViewTextBoxColumn2
	    // 
	    this.dataGridViewTextBoxColumn2.DataPropertyName = "TOTALSALES";
	    this.dataGridViewTextBoxColumn2.HeaderText = "TOTALSALES";
	    this.dataGridViewTextBoxColumn2.Name = "dataGridViewTextBoxColumn2";
	    // 
	    // Form1
	    // 
	    this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
	    this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
	    this.ClientSize = new System.Drawing.Size(569, 362);
	    this.Controls.Add(this.vIEWSALESORDERSDataGridView);
	    this.Controls.Add(iDLabel);
	    this.Controls.Add(this.iDTextBox);
	    this.Controls.Add(nAMELabel);
	    this.Controls.Add(this.nAMETextBox);
	    this.Controls.Add(dESCRIPTIONLabel);
	    this.Controls.Add(this.dESCRIPTIONTextBox);
	    this.Controls.Add(sIZELabel);
	    this.Controls.Add(this.sIZETextBox);
	    this.Controls.Add(cOLORLabel);
	    this.Controls.Add(this.cOLORTextBox);
	    this.Controls.Add(qUANTITYLabel);
	    this.Controls.Add(this.qUANTITYTextBox);
	    this.Controls.Add(uNITPRICELabel);
	    this.Controls.Add(this.uNITPRICETextBox);
	    this.Controls.Add(pHOTOLabel);
	    this.Controls.Add(this.pHOTOPictureBox);
	    this.Controls.Add(this.pRODUCTSBindingNavigator);
	    this.Name = "Form1";
	    this.Text = "Form1";
	    this.Load += new System.EventHandler(this.Form1_Load);
	    ((System.ComponentModel.ISupportInitialize)(this.pRODUCTSBindingNavigator)).EndInit();
	    this.pRODUCTSBindingNavigator.ResumeLayout(false);
	    this.pRODUCTSBindingNavigator.PerformLayout();
	    ((System.ComponentModel.ISupportInitialize)(this.pHOTOPictureBox)).EndInit();
	    ((System.ComponentModel.ISupportInitialize)(this.pRODUCTSBindingSource)).EndInit();
	    ((System.ComponentModel.ISupportInitialize)(this.dataSet1)).EndInit();
	    ((System.ComponentModel.ISupportInitialize)(this.vIEWSALESORDERSBindingSource)).EndInit();
	    ((System.ComponentModel.ISupportInitialize)(this.vIEWSALESORDERSDataGridView)).EndInit();
	    this.ResumeLayout(false);
	    this.PerformLayout();

	}

	#endregion

	private DataSet1 dataSet1;
	private System.Windows.Forms.BindingSource pRODUCTSBindingSource;
	private DataSet1TableAdapters.PRODUCTSTableAdapter pRODUCTSTableAdapter;
	private DataSet1TableAdapters.TableAdapterManager tableAdapterManager;
	private System.Windows.Forms.BindingNavigator pRODUCTSBindingNavigator;
	private System.Windows.Forms.ToolStripButton bindingNavigatorAddNewItem;
	private System.Windows.Forms.ToolStripLabel bindingNavigatorCountItem;
	private System.Windows.Forms.ToolStripButton bindingNavigatorDeleteItem;
	private System.Windows.Forms.ToolStripButton bindingNavigatorMoveFirstItem;
	private System.Windows.Forms.ToolStripButton bindingNavigatorMovePreviousItem;
	private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator;
	private System.Windows.Forms.ToolStripTextBox bindingNavigatorPositionItem;
	private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator1;
	private System.Windows.Forms.ToolStripButton bindingNavigatorMoveNextItem;
	private System.Windows.Forms.ToolStripButton bindingNavigatorMoveLastItem;
	private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator2;
	private System.Windows.Forms.ToolStripButton pRODUCTSBindingNavigatorSaveItem;
	private System.Windows.Forms.TextBox iDTextBox;
	private System.Windows.Forms.TextBox nAMETextBox;
	private System.Windows.Forms.TextBox dESCRIPTIONTextBox;
	private System.Windows.Forms.TextBox sIZETextBox;
	private System.Windows.Forms.TextBox cOLORTextBox;
	private System.Windows.Forms.TextBox qUANTITYTextBox;
	private System.Windows.Forms.TextBox uNITPRICETextBox;
	private System.Windows.Forms.PictureBox pHOTOPictureBox;
	private System.Windows.Forms.BindingSource vIEWSALESORDERSBindingSource;
	private DataSet1TableAdapters.VIEWSALESORDERSTableAdapter vIEWSALESORDERSTableAdapter;
	private System.Windows.Forms.DataGridView vIEWSALESORDERSDataGridView;
	private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn1;
	private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn2;
    }
}

