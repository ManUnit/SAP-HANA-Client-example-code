package main

import (
	"context"
	"database/sql"
	"flag"
	"log"
	"math"
	"time"
)

//To run this use: go run statement_examples.go -dsn hdb://user:password@host:port
func testGeneral(db *sql.DB) {
	//Drop the table if it exists and ignore the errors
	_, _ = db.Exec("DROP TABLE TAB")

	//Create a table
	_, err := db.Exec("CREATE TABLE TAB (A DECIMAL(25, 4), B TIMESTAMP)")
	if err != nil {
		log.Fatal(err)
	}

	//Please look at transaction_examples.go for examples on using a statement
	//within a transaction.
	//Prepare a statement once and it can be used multiple times
	stmt, err := db.Prepare("INSERT INTO TAB VALUES(?, ?)")
	if err != nil {
		log.Fatal(err)
	}

	//Now use the prepared statement created above to insert multiple values in the table
	res, err := stmt.Exec(2311.12345, time.Now())
	if err != nil {
		log.Fatal(err)
	}
	rowsAffected, err := res.RowsAffected()
	if err != nil {
		log.Fatal(err)
	}
	log.Printf("%d rows affected ", rowsAffected)

	res, err = stmt.Exec(-332.2249, time.Date(2017, 11, 1, 18, 12, 22, 123456789, time.Local))
	if err != nil {
		log.Fatal(err)
	}
	rowsAffected, err = res.RowsAffected()
	if err != nil {
		log.Fatal(err)
	}
	log.Printf("%d rows affected ", rowsAffected)

	//Set a timeout of 5 seconds
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	res, err = stmt.ExecContext(ctx, 1.00129, time.Date(1998, 03, 01, 10, 03, 11, 0, time.Local))
	if err != nil {
		log.Fatal(err)
	}
	rowsAffected, err = res.RowsAffected()
	if err != nil {
		log.Fatal(err)
	}
	log.Printf("%d rows affected ", rowsAffected)

	//Once done with the prepared statement close it
	err = stmt.Close()
	if err != nil {
		log.Fatal(err)
	}

	//Set a timeout of 8 seconds
	ctx, cancel = context.WithTimeout(context.Background(), 8*time.Second)
	defer cancel()
	queryStmt, err := db.Prepare("SELECT * FROM TAB")

	if err != nil {
		log.Fatal(err)
	}

	rows, err := queryStmt.QueryContext(ctx)
	if err != nil {
		log.Fatal(err)
	}

	//Now iterate over the returned rows to get the returned values
	var retDec string
	var retTs time.Time
	for {
		if !rows.Next() {
			break
		}
		err = rows.Scan(&retDec, &retTs)
		if err != nil {
			log.Fatal(err)
		}
		log.Printf("Value is: %s %s", retDec, retTs)
	}

	//Close the rows when done
	err = rows.Close()
	if err != nil {
		log.Fatal(err)
	}

	//Get the first row in the result set
	err = queryStmt.QueryRow().Scan(&retDec, &retTs)
	if err != nil {
		log.Fatal(err)
	}
	log.Printf("Value is: %s %s", retDec, retTs)

	//Close the statement when done
	err = queryStmt.Close()
	if err != nil {
		log.Fatal(err)
	}
}

func testBulkInsert(db *sql.DB) {
	_, _ = db.Exec("DROP TABLE TAB")
	res, err := db.Exec("CREATE TABLE TAB(COL1 INT, COL2 DOUBLE, COL3 BOOLEAN, COL4 DECIMAL(28), " +
		"COL5 NVARCHAR(20), COL6 VARBINARY(20), COL7 TIME, COL8 DATE, COL9 TIMESTAMP, " +
		"COL10 NCLOB, COL11 BLOB")
	_ = res

	if err != nil {
		log.Fatal(err)
		return
	}

	_ = doInsert(db)
	doFetch(db)
}

func testBulkUpdate(db *sql.DB) {
	_, _ = db.Exec("DROP TABLE TAB")
	res, err := db.Exec("CREATE TABLE TAB(COL1 INT, COL2 DOUBLE, COL3 BOOLEAN, COL4 DECIMAL(28), " +
		"COL5 NVARCHAR(20), COL6 VARBINARY(20), COL7 TIME, COL8 DATE, COL9 TIMESTAMP, " +
		"COL10 NCLOB, COL11 BLOB")
	_ = res

	if err != nil {
		log.Fatal(err)
		return
	}

	batchValues := doInsert(db)
	_ = doUpdate(db, batchValues)
	doFetch(db)
}

func testBulkDelete(db *sql.DB) {
	_, _ = db.Exec("DROP TABLE TAB")
	res, err := db.Exec("CREATE TABLE TAB(COL1 INT, COL2 DOUBLE, COL3 BOOLEAN, COL4 DECIMAL(28), " +
		"COL5 NVARCHAR(20), COL6 VARBINARY(20), COL7 TIME, COL8 DATE, COL9 TIMESTAMP, " +
		"COL10 NCLOB, COL11 BLOB")
	_ = res

	if err != nil {
		log.Fatal(err)
		return
	}

	batchValues := doInsert(db)
	doDelete(db, batchValues)
	doFetch(db) // Should show no values
}

func doInsert(db *sql.DB) [][]interface{} {
	stmt, err := db.Prepare("INSERT INTO TAB VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")

	if err != nil {
		log.Fatal(err)
		return nil
	}
	defer stmt.Close()

	batchSize := 50
	batchValues := createBatchValues(batchSize)

	_, err = stmt.Exec(batchValues)

	if err != nil {
		log.Fatal(err)
		return nil
	}

	return batchValues
}

func doUpdate(db *sql.DB, batchValues [][]interface{}) [][]interface{} {
	stmt, err := db.Prepare("UPDATE TAB SET COL2 = ? WHERE COL1 = ?")

	if err != nil {
		log.Fatal(err)
		return nil
	}
	defer stmt.Close()

	newColumnValues := getNewSingleColumnValues(batchValues, 2)
	newBatchValues := replaceColumnValues(batchValues, newColumnValues, 2)

	_, err = stmt.Exec(batchValues)

	if err != nil {
		log.Fatal(err)
		return nil
	}

	return newBatchValues
}

func doDelete(db *sql.DB, batchValues [][]interface{}) {
	stmt, err := db.Prepare("DELETE FROM TAB WHERE COL1 = ?")

	if err != nil {
		log.Fatal(err)
		return
	}
	defer stmt.Close()

	primaryKeyColumnValues := getSingleColumnValues(batchValues, 1)

	_, err = stmt.Exec(primaryKeyColumnValues)

	if err != nil {
		log.Fatal(err)
		return
	}
}

func createBatchValues(batchSize int) [][]interface{} {
	time := time.Now()
	testString := "abcdefg"
	testBytes := []byte(testString)
	data := make([][]interface{}, batchSize)

	for i := 0; i < batchSize; i++ {
		data[i] = []interface{}{int16(i), float64(i), true, math.MaxInt32, testString,
			testBytes, time, time, time, testString, testBytes}
	}
	return data
}

func doFetch(db *sql.DB) {
	rows, err := db.Query("SELECT COL1, COL2, COL3, COL4 , COL5 , COL6 , COL7, COL8, " +
		"COL9, COL10, COL11 FROM TAB ORDER BY COL1 ASC")
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	columnValues := make([]sql.NullString, 11)
	rowCount := 0

	for rows.Next() {
		rowCount++
		err = rows.Scan(&columnValues[0], &columnValues[1], &columnValues[2], &columnValues[3],
			&columnValues[4], &columnValues[5], &columnValues[6], &columnValues[7],
			&columnValues[8], &columnValues[9], &columnValues[10])

		if err != nil {
			log.Fatal(err)
		}
		log.Println("Row ", rowCount, "Values are: ",
			"COL1 (", columnValues[0].String, ")",
			"COL2 (", columnValues[1].String, ")",
			"COL3 (", columnValues[2].String, ")",
			"COL4 (", columnValues[3].String, ")",
			"COL5 (", columnValues[4].String, ")",
			"COL6 (", columnValues[5].String, ")",
			"COL7 (", columnValues[6].String, ")",
			"COL8 (", columnValues[7].String, ")",
			"COL9 (", columnValues[8].String, ")",
			"COL10 (", columnValues[9].String, ")",
			"COL11 (", columnValues[10].String, ")")
	}

	log.Println("Number of rows received: ", rowCount)
}

func getNewSingleColumnValues(allRows [][]interface{}, columnIndex int) [][]interface{} {
	// columns = col1 int, col2 double, col3 boolean, col4 decimal(28), col5 nvarchar(20),
	// col6 varbinary(20), col7 time, col8 date, col9 timestamp, col10 nclob, col11 blob
	batchSize := len(allRows)
	data := make([][]interface{}, batchSize)
	theTime := time.Now()
	theTime = time.Date(theTime.Year()-1, theTime.Month(), theTime.Day(), theTime.Hour(),
		theTime.Minute(), theTime.Second(), theTime.Nanosecond(), theTime.Location())
	theNewString := "xxxxxxx"
	theNewBinary := []byte(theNewString)

	for rowIndex := 0; rowIndex < batchSize; rowIndex++ {
		if columnIndex == 2 { // Boolean
			data[rowIndex] = []interface{}{false, int16(rowIndex)}
		} else if columnIndex == 5 { // Binary
			data[rowIndex] = []interface{}{theNewBinary, int16(rowIndex)}
		} else if columnIndex < 4 { // Numeric
			data[rowIndex] = []interface{}{int(-1), int16(rowIndex)}
		} else if (columnIndex == 4) || (columnIndex >= 9 && columnIndex < 11) { // String
			data[rowIndex] = []interface{}{"xxxxxxx", int16(rowIndex)}
		} else { // Date/Time/Timestamp
			data[rowIndex] = []interface{}{theTime, int16(rowIndex)}
		}
	}

	return data
}

func replaceColumnValues(batchValues [][]interface{}, newColumnValues [][]interface{},
	changedColumnIndex int) [][]interface{} {
	batchSize := len(batchValues)
	data := make([][]interface{}, batchSize)

	for rowIndex := 0; rowIndex < batchSize; rowIndex++ {
		data[rowIndex] = []interface{}{batchValues[rowIndex][0], batchValues[rowIndex][1],
			batchValues[rowIndex][2], batchValues[rowIndex][3], batchValues[rowIndex][4],
			batchValues[rowIndex][5], batchValues[rowIndex][6], batchValues[rowIndex][7],
			batchValues[rowIndex][8], batchValues[rowIndex][9], batchValues[rowIndex][10]}
		data[rowIndex][changedColumnIndex] = newColumnValues[rowIndex][0]
	}

	return data
}

func getSingleColumnValues(allRows [][]interface{}, columnIndex int) [][]interface{} {
	batchSize := len(allRows)
	data := make([][]interface{}, batchSize)

	for rowIndex := 0; rowIndex < batchSize; rowIndex++ {
		data[rowIndex] = []interface{}{allRows[rowIndex][columnIndex-1]}
	}
	return data
}

func main() {
	var connStr string
	//dsn is of the form: hdb://user:password@host:port?connectProp1=value&connectProp2=value
	flag.StringVar(&connStr, "dsn", "hdb://user:password@host:port", "database dsn")

	if !flag.Parsed() {
		flag.Parse()
	}

	//The name of the HANA driver is hdb
	db, err := sql.Open("hdb", connStr)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	testGeneral(db)
	testBulkInsert(db)
	testBulkUpdate(db)
	testBulkDelete(db)
}
