/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author HP - Gia Khiêm
 */
public class testDB {
    public static void main(String[] args) throws SQLException {
        DBContext db = new DBContext();

            // Nếu DBContext của bạn đang giữ conn public:
            Connection con = db.conn;

            if (con == null) {
                System.out.println("❌ Connection is NULL");
                return;
            }

            if (!con.isValid(3)) {
                System.out.println("❌ Connection is NOT valid");
                return;
            }

            DatabaseMetaData meta = con.getMetaData();
            System.out.println("✅ Connected successfully!");
            System.out.println("Driver: " + meta.getDriverName() + " - " + meta.getDriverVersion());
            System.out.println("DB: " + meta.getDatabaseProductName() + " - " + meta.getDatabaseProductVersion());
            System.out.println("URL: " + meta.getURL());
            System.out.println("User: " + meta.getUserName());

          

            con.close();
            System.out.println("✅ Connection closed.");

       }}


