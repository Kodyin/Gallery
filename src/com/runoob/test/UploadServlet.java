package com.runoob.test;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
 

/**
 * Servlet implementation class UploadServlet
 */
@WebServlet("/UploadServlet")
public class UploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
     
   
    private static final String UPLOAD_DIRECTORY = "image";
 
    private String dbURL = "jdbc:mysql://kodyin.com:3306/gallery";
    private String dbUser = "gallery";
    private String dbPass = "eecs118";
   
    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB
 
  
    protected void doPost(HttpServletRequest request,
        HttpServletResponse response) throws ServletException, IOException {
    	
    	String title = request.getParameter("title1");
    	String gallery_id = request.getParameter("gallery_id1");
		String artist_id = request.getParameter("artist_id");
		String year = request.getParameter("year");
		String type = request.getParameter("type");
		String width = request.getParameter("width");
		String height = request.getParameter("height");
		String location = request.getParameter("location");
		String description = request.getParameter("description");
		

        if (!ServletFileUpload.isMultipartContent(request)) {
            
            PrintWriter writer = response.getWriter();
            writer.println("Error: MUST CONTAIN enctype=multipart/form-data");
            writer.flush();
            return;
        }
 
        DiskFileItemFactory factory = new DiskFileItemFactory();
        
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
 
        ServletFileUpload upload = new ServletFileUpload(factory);
         
        upload.setFileSizeMax(MAX_FILE_SIZE);
         
        upload.setSizeMax(MAX_REQUEST_SIZE);
        
        upload.setHeaderEncoding("UTF-8"); 

        
        String uploadPath = getServletContext().getRealPath("/") + UPLOAD_DIRECTORY;
        String fileN = "";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
 
        try {
           
            List<FileItem> formItems = upload.parseRequest(request);
 
            if (formItems != null && formItems.size() > 0) {
                
                for (FileItem item : formItems) {
                    
                    if (!item.isFormField()) {
                        String fileName = new File(item.getName()).getName();
                        String filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);
                        fileN = fileName;
                        System.out.println(filePath);
                        item.write(storeFile);
                        request.setAttribute("message",
                            "Success!");
                    }
                    else{
                    	if(item.getFieldName().equals("title1")){
    		                title =item.getString("UTF-8"); 
    					}
    					else if(item.getFieldName().equals("gallery_id1")){
    		                gallery_id =item.getString("UTF-8"); 
    					}
    					else if(item.getFieldName().equals("artist_id1")){
    		                artist_id =item.getString("UTF-8"); 
    					}
    					else if(item.getFieldName().equals("year1")){
    		                year =item.getString("UTF-8"); 
    					}
    					else if(item.getFieldName().equals("type1")){
    		                type =item.getString("UTF-8"); 
    					}
    					else if(item.getFieldName().equals("width1")){
    		                width =item.getString("UTF-8"); 
    					}
    					else if(item.getFieldName().equals("height1")){
    		                height =item.getString("UTF-8"); 
    					}
    					else if(item.getFieldName().equals("location1")){
    		                location =item.getString("UTF-8"); 
    					}
    					else if(item.getFieldName().equals("description1")){
    		                description =item.getString("UTF-8"); 
    					}
                    }
                }
            }
        } catch (Exception ex) {
            request.setAttribute("message",
                    "Error: " + ex.getMessage());
        }
        
        Connection conn = null; // connection to the database
        
        
        try {
            // connects to the database
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
 
            // constructs SQL statement
            String sql = "insert into image values(default,?,?,?,?,default)";
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.clearParameters();
			pstmt.setString(1, title);
			pstmt.setString(2, "image/" + fileN);
			pstmt.setString(3, gallery_id);
			pstmt.setString(4, artist_id);
			pstmt.executeUpdate();
			ResultSet rs=pstmt.getGeneratedKeys();
			int iid=0;
			while (rs.next()) {
			iid = rs.getInt(1);
			}
			pstmt = conn.prepareStatement("UPDATE `gallery`.`image` SET `detail_id`='"+ Integer.toString(iid)+ "' WHERE `image_id`='"+ Integer.toString(iid)+ "';",Statement.RETURN_GENERATED_KEYS);
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("insert into detail values(default,?,?,?,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, Integer.toString(iid));
			pstmt.setString(2, year);
			pstmt.setString(3, type);
			pstmt.setString(4, width);
			pstmt.setString(5, height);
			pstmt.setString(6, location);
			pstmt.setString(7, description);
			pstmt.executeUpdate();
        }
        catch(Exception e) {
        	request.setAttribute("message",
                    "Error: " + e.getMessage());
		}
        getServletContext().getRequestDispatcher("/message.jsp").forward(
                request, response);
			
    }
}