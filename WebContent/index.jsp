
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  	<title>My Gallery</title>
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  	<link href='https://fonts.googleapis.com/css?family=Oxygen:400,300,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Lora' rel='stylesheet' type='text/css'>
  	<style type="text/css">
		body{
			background: #C9D6FF;  /* fallback for old browsers */
			background: -webkit-linear-gradient(to right, #E2E2E2, #C9D6FF);  /* Chrome 10-25, Safari 5.1-6 */
			background: linear-gradient(to right, #E2E2E2, #C9D6FF); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
			font-size: 16px;
  			color: black;
  			font-family: 'Lora';
		}
		header{
			background-color: #FFFFFF;
		}
		.navbar-brand{
			font-size: 5em;
			font-family: cursive;
			text-decoration: none;
			margin:20px;
		}
		.nav-link{
			color : #52527a ;
		}
		.addform{
			margin: auto;
			width: 20%;
        	clear: both;
		}
		 .addform input {
        	width: 100%;
        	clear: both;
    	}
    	.findform{
			margin: auto;
			width: 75%;
        	clear: both;
		}
		 .findform input {
        	width: 100%;
        	clear: both;
    	}
		.col-sm-7{
			color #3d3d3d;
  			flex 4;
		}
		.col-sm-5{
			background-color #3d3d3d;
  			color #efefef;
  			width 20rem;
  			flex 2;
  			min-width 20rem;
		}
		.thumbnail{
			background-color: #d5dceb;
			text-align: center;
			margin: auto;
			max-width: auto;

		}
		.thumbnail>img {
    		display: block;
    		width: 100%;
    		height: 20%;
		}
		.imagebutton {
    		display: block;
    		width: 100%;
    		height: 30%;
    		margin:auto;
		}
		.imagepreview {
    		display: block;
    		width: 100%;
    		height: 20%;
    		margin:auto;
		}
		.row{
			margin:auto;
		}
		.view {
			margin: auto;
   			background-color: white;
    		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
		}

		.fullimg {
			display: block;
			max-width: 100%;
			height: auto;
    		margin-left: auto;
    		margin-right: auto;
		}
		.info{
			text-align: center;
  			padding: 5px 5px;
		}
		.link {
    		display: block;

    		color: blue;
    		cursor: pointer;
    		text-align: center;
  			padding: 5px 5px;
		}
		.artistdetail{
			display: none;
			text-align: center;
			padding: 5px 5px;
		}
		button, input, optgroup, select, textarea {
    		margin: auto;
		}
		#navbarNav{
			margin-left: 20%
		}
		#buttonform{
			margin-top: 2%;
			margin-left: 35%;
    		font-size: 20px;
		}
		input{
			box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
		}
		.buttons{
			margin: 3px;
			box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
		}
		
  

	</style>
</head>

<body>
	<header>
		<nav class="header-nav">
			<div class="container">
				<div class="navbar-brand">
            		<a style= "text-decoration: none;" href="index.jsp">My Gallery</a>
          		</div>
			 	<div class="collapse navbar-collapse" id="navbarNav">
    				<div style="margin-left: 10%;">
  						<form id="buttonform" method="post">
    						<input class="buttons" type="submit" name="listcontent" value="List Menu" />
    						<input class="buttons" type="submit" name="addcontent" value="Add Menu" />
    						<input class="buttons" type="submit" name="modify" value="Modify and Delete" />
    						<input class="buttons" type="submit" name="find" value="Find" />
						</form>
  					</div>
  				</div>
  			</div>
		</nav>	
	</header>


	<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ page import="java.util.*"%>
  	<%@ page import="java.io.*" %>
  	<%@ page import="java.sql.*"%>

  	<hr>


	<% 
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		}
		catch(Exception e) {
			out.println("can't load mysql driver");
			out.println(e.toString());
		}

		String url="jdbc:mysql://kodyin.com:3306/gallery";
		String id="gallery";
		String pwd="eecs118";
		Connection con=
		DriverManager.getConnection(url,id,pwd);
	%>
	
	<% 
		
		String add = "";
		int galleryClicked = 0, imageClicked = 0, artist;
		out.println(add);
		Statement outer = con.createStatement();
		String selectall="SELECT * FROM gallery";
		ResultSet countga=outer.executeQuery(selectall);
		while (countga.next())
		{
			if (request.getParameter("gallery"+countga.getString("gallery_id")+ ".x")!=null) galleryClicked = Integer.parseInt(countga.getString("gallery_id"));
		}
		String selectimg="SELECT * FROM image";
		ResultSet countimg=outer.executeQuery(selectimg);
		while (countimg.next())
		{
			if (request.getParameter("image"+countimg.getString("image_id")+ ".x")!=null) {
				imageClicked = Integer.parseInt(countimg.getString("image_id"));
				galleryClicked = Integer.parseInt(countimg.getString("gallery_id"));
			}
		}
		if(request.getParameter("find") != null || request.getParameter("findtype") != null || request.getParameter("findyear") != null || request.getParameter("findname") != null || request.getParameter("findlocation")!=null || request.getParameter("findcountry") != null || request.getParameter("findbirth") != null){
	%>
	<div class="col-sm-4">
		<div class ="findform"> 
			<form method="post"> 
				Find by Type: <input name="type" type="text"> 
				<input type="submit" name = "findtype" value="Find"/>
			</form>
		</div>
		<div class ="findform"> 
			<form method="post"> 
				From <input name="fromyear" style="width: 120px;"  type="text"> To <input name="toyear" style="width: 120px;" type="text"> 
				<input type="submit" name = "findyear" value="Find"/>
			</form>
		</div>
		<div style="text-align: center;margin-top: -3%;margin-bottom: 2%;">Leave Blank as Infinity</div>
		<div class ="findform"> 
			<form method="post"> 
				Find by Artist Name: <input name="artist_name" type="text"> 
				<input type="submit" name = "findname" value="Find"/>
			</form>
		</div>
		<div class ="findform"> 
			<form method="post"> 
				Find by Location: <input name="location" type="text"> 
				<input type="submit" name = "findlocation" value="Find"/>
			</form>
		</div>
		<div class ="findform"> 
			<form method="post"> 
				Find by Country: <input name="country" type="text"> 
				<input type="submit" name = "findcountry" value="Find"/>
			</form>
		</div>
		<div class ="findform"> 
			<form method="post"> 
				Find by Birth Year: <input name="birth" type="text"> 
				<input type="submit" name = "findbirth" value="Find"/>
			</form>
		</div>
	</div>

	<%
			if(request.getParameter("findtype") != null && !request.getParameter("type").isEmpty()){
            	String type = request.getParameter("type"); 
				Statement stmt = con.createStatement();
				String select= "SELECT * FROM image as i, detail as d WHERE i.image_id = d.image_id AND d.type ='" + type + "';";
				ResultSet rs = null;
				try {
					rs=stmt.executeQuery(select);
				}
				catch(Exception e) {
					out.println(e.toString());
				}
				out.println("<div class=\"col-sm-8\">");
				while (rs.next()){
					out.println("<div class=\"col-sm-4\">");
					out.println("<div class=\"thumbnail\">");
					out.println(" <img src=\"" + rs.getString("link") + "\">");
					out.println("Image ID:  " +  rs.getString("image_id") + "<br>" );
					out.println("Title:  " + rs.getString("title") + "<br>");
					out.println("Type:  " + rs.getString("type"));
					out.println("</div>");
					out.println("</div>");
				}
				out.println("</div>");
			}
			if(request.getParameter("findyear") != null){
            	String from = request.getParameter("fromyear");
            	String to = request.getParameter("toyear"); 
				Statement stmt = con.createStatement();
				String select= "SELECT * FROM `gallery`.`image` as i, `gallery`.`detail` as d WHERE i.image_id = d.image_id ";
				if(request.getParameter("fromyear") != "") select+= " AND year>= " + from;
				if(request.getParameter("toyear") != "") select+= " AND year<= " + to;
				ResultSet rs = null;
				try {
					rs=stmt.executeQuery(select);
				}
				catch(Exception e) {
					out.println(e.toString());
				}
				out.println("<div class=\"col-sm-8\">");
				while (rs.next()){
					out.println("<div class=\"col-sm-4\">");
					out.println("<div class=\"thumbnail\">");
					out.println(" <img src=\"" + rs.getString("link") + "\">");
					out.println("Image ID:  " +  rs.getString("image_id") + "<br>" );
					out.println("Title:  " + rs.getString("title") + "<br>");
					out.println("Year:  " + rs.getString("year"));
					out.println("</div>");
					out.println("</div>");
				}
				out.println("</div>");
			}
			if(request.getParameter("findname") != null){
            	String name = request.getParameter("artist_name"); 
				Statement stmt = con.createStatement();
				String select= "SELECT * FROM image as i, artist as a WHERE i.artist_id = a.artist_id AND a.name ='" + name + "';";
				ResultSet rs = null;
				try {
					rs=stmt.executeQuery(select);
				}
				catch(Exception e) {
					out.println(e.toString());
				}
				out.println("<div class=\"col-sm-8\">");
				while (rs.next()){
					out.println("<div class=\"col-sm-4\">");
					out.println("<div class=\"thumbnail\">");
					out.println(" <img src=\"" + rs.getString("link") + "\">");
					out.println("Image ID:  " +  rs.getString("image_id") + "<br>" );
					out.println("Title:  " + rs.getString("title") + "<br>");
					out.println("Artist ID:  " + rs.getString("artist_id")+ "<br>");
					out.println("Artist Name:  " + rs.getString("name"));
					out.println("</div>");
					out.println("</div>");
				}
				out.println("</div>");
			}	
			if(request.getParameter("findlocation") != null){
            	String location = request.getParameter("location"); 
				Statement stmt = con.createStatement();
				String select= "SELECT * FROM image as i, detail as d WHERE i.image_id = d.image_id AND d.location ='" + location + "';";
				ResultSet rs = null;
				try {
					rs=stmt.executeQuery(select);
				}
				catch(Exception e) {
					out.println(e.toString());
				}
				out.println("<div class=\"col-sm-8\">");
				while (rs.next()){
					out.println("<div class=\"col-sm-4\">");
					out.println("<div class=\"thumbnail\">");
					out.println(" <img src=\"" + rs.getString("link") + "\">");
					out.println("Image ID:  " +  rs.getString("image_id") + "<br>" );
					out.println("Title:  " + rs.getString("title") + "<br>");
					out.println("Location:  " + rs.getString("location"));
					out.println("</div>");
					out.println("</div>");
				}
				out.println("</div>");
			}
			if(request.getParameter("findcountry") != null){
            	String country = request.getParameter("country"); 
				Statement stmt = con.createStatement();
				String select= "SELECT * FROM image as i, artist as a WHERE i.artist_id = a.artist_id AND a.country ='" + country + "';";
				ResultSet rs = null;
				try {
					rs=stmt.executeQuery(select);
				}
				catch(Exception e) {
					out.println(e.toString());
				}
				out.println("<div class=\"col-sm-8\">");
				while (rs.next()){
					out.println("<div class=\"col-sm-4\">");
					out.println("<div class=\"thumbnail\">");
					out.println(" <img src=\"" + rs.getString("link") + "\">");
					out.println("Image ID:  " +  rs.getString("image_id") + "<br>" );
					out.println("Title:  " + rs.getString("title") + "<br>");
					out.println("Artist ID:  " + rs.getString("artist_id")+ "<br>");
					out.println("Artist Name:  " + rs.getString("name") + "<br>");
					out.println("Country:  " + rs.getString("country"));
					out.println("</div>");
					out.println("</div>");
				}
				out.println("</div>");
			}	
			if(request.getParameter("findbirth") != null){
            	String birth = request.getParameter("birth"); 
				Statement stmt = con.createStatement();
				String select= "SELECT * FROM image as i, artist as a WHERE i.artist_id = a.artist_id AND a.birth_year ='" + birth + "';";
				ResultSet rs = null;
				try {
					rs=stmt.executeQuery(select);
				}
				catch(Exception e) {
					out.println(e.toString());
				}
				out.println("<div class=\"col-sm-8\">");
				while (rs.next()){
					out.println("<div class=\"col-sm-4\">");
					out.println("<div class=\"thumbnail\">");
					out.println(" <img src=\"" + rs.getString("link") + "\">");
					out.println("Image ID:  " +  rs.getString("image_id") + "<br>" );
					out.println("Title:  " + rs.getString("title") + "<br>");
					out.println("Artist ID:  " + rs.getString("artist_id")+ "<br>");
					out.println("Artist Name:  " + rs.getString("name") + "<br>");
					out.println("Birth Year:  " + rs.getString("birth_year"));
					out.println("</div>");
					out.println("</div>");
				}
				out.println("</div>");
			}	
		}


		if(request.getParameter("modify") != null || request.getParameter("delButton") != null || request.getParameter("modifyImageButton") != null || request.getParameter("modifyArtistButton") != null || request.getParameter("modifyGalleryButton") != null){
	%>
	<div class ="addform"> 
		<form method="post"> 
			Input the Image ID to Delete: <input name="del_id" type="text"> 
			<input type="submit" name = "delButton" value="Delete"/>
		</form>
	</div>
	<div class ="addform"> 
		<form method="post"> 
			Image ID: <input name="modi_image_id" type="text">
			Title: <input name="modi_title" type="text"> 
			Link: <input name="modi_link" type="text">  
			Year: <input name="modi_year" type="text"> 
			Type: <input name="modi_type" type="text"> 
			Width: <input name="modi_width" type="text"> 
			Height: <input name="modi_height" type="text"> 
			Location: <input name="modi_location" type="text"> 
			Description: <input name="modi_description" type="text"> 
			<input type="submit" name = "modifyImageButton" value="Modify Image Details"/>
		</form>
	</div>
	<div class="addform">
		<form method="post">
			Artist ID: <input name="modi_artist_id" type="text"> 
			Name: <input name="modi_artist_name" type="text"> 
			Birth Year: <input name="modi_birth_year" type="text"> 
			Country: <input name="modi_country" type="text"> 
			Description: <input name="modi_artist_description" type="text"> 
			<input type="submit" name = "modifyArtistButton" value="Modify Artist Details"/>
		</form>
	</div>
	<div class="addform">
		<form method="post">
			Gallery ID: <input name="modi_gallery_id" type="text"> 
			Name: <input name="modi_gallery_name" type="text"> 
			Description: <input name="modi_gallery_description" type="text"> 
			<input type="submit" name = "modifyGalleryButton" value="Modify Gallery Details"/>
		</form>
	</div> 
	<%
			if(request.getParameter("delButton") != null && !request.getParameter("del_id").isEmpty()){
            	String del_id = request.getParameter("del_id");
				PreparedStatement pstmt = con.prepareStatement("DELETE FROM `gallery`.`image` WHERE `image_id`='"+ del_id +"';",Statement.RETURN_GENERATED_KEYS);
				pstmt.clearParameters();
				try {
					pstmt.executeUpdate();
				}
				catch(Exception e) {
					out.println(e.toString());
				}
				ResultSet rs=pstmt.getGeneratedKeys();
				out.println("Successfully Deleted. image_id:"+ del_id + "<div></div>");
				pstmt = con.prepareStatement("DELETE FROM `gallery`.`detail` WHERE `image_id`='"+ del_id +"';",Statement.RETURN_GENERATED_KEYS);
				pstmt.clearParameters();
				try {
					pstmt.executeUpdate();
				}
				catch(Exception e) {
					out.println(e.toString());
				}
				rs=pstmt.getGeneratedKeys();
				out.println("Successfully Deleted detail!");
			}	
			if(request.getParameter("modifyImageButton") != null && !request.getParameter("modi_image_id").isEmpty()){
            	String img_id = request.getParameter("modi_image_id");
            	String title = request.getParameter("modi_title");
            	String link = request.getParameter("modi_link");
            	String year = request.getParameter("modi_year");
            	String type = request.getParameter("modi_type");
            	String width = request.getParameter("modi_width");
            	String height = request.getParameter("modi_height");
            	String location = request.getParameter("modi_location");
            	String description = request.getParameter("modi_description");
				PreparedStatement pstmt;
				if(!title.isEmpty()) {
					pstmt = con.prepareStatement("UPDATE `gallery`.`image` SET `title`='"+ title +"' WHERE `image_id`='"+img_id+"';",Statement.RETURN_GENERATED_KEYS);
					pstmt.clearParameters();
					try {pstmt.executeUpdate();}
					catch(Exception e) {out.println(e.toString());}
					ResultSet rs=pstmt.getGeneratedKeys();
					out.println("Title modified!" + "<div></div>");
				}
				if(!link.isEmpty()) {
					pstmt = con.prepareStatement("UPDATE `gallery`.`image` SET `link`='"+ link +"' WHERE `image_id`='"+img_id+"';",Statement.RETURN_GENERATED_KEYS);
					pstmt.clearParameters();
					try {pstmt.executeUpdate();}
					catch(Exception e) {out.println(e.toString());}
					ResultSet rs=pstmt.getGeneratedKeys();
					out.println("Link modified!" + "<div></div>");
				}
				if(!year.isEmpty()) {
					pstmt = con.prepareStatement("UPDATE `gallery`.`detail` SET `year`='"+ year +"' WHERE `image_id`='"+img_id+"';",Statement.RETURN_GENERATED_KEYS);
					pstmt.clearParameters();
					try {pstmt.executeUpdate();}
					catch(Exception e) {out.println(e.toString());}
					ResultSet rs=pstmt.getGeneratedKeys();
					out.println("Year modified!" + "<div></div>");
				}
				if(!type.isEmpty()) {
					pstmt = con.prepareStatement("UPDATE `gallery`.`detail` SET `type`='"+ type +"' WHERE `image_id`='"+img_id+"';",Statement.RETURN_GENERATED_KEYS);
					pstmt.clearParameters();
					try {pstmt.executeUpdate();}
					catch(Exception e) {out.println(e.toString());}
					ResultSet rs=pstmt.getGeneratedKeys();
					out.println("Type modified!" + "<div></div>");
				}
				if(!width.isEmpty()) {
					pstmt = con.prepareStatement("UPDATE `gallery`.`detail` SET `width`='"+ width +"' WHERE `image_id`='"+img_id+"';",Statement.RETURN_GENERATED_KEYS);
					pstmt.clearParameters();
					try {pstmt.executeUpdate();}
					catch(Exception e) {out.println(e.toString());}
					ResultSet rs=pstmt.getGeneratedKeys();
					out.println("Width modified!" + "<div></div>");
				}
				if(!height.isEmpty()) {
					pstmt = con.prepareStatement("UPDATE `gallery`.`detail` SET `height`='"+ height +"' WHERE `image_id`='"+img_id+"';",Statement.RETURN_GENERATED_KEYS);
					pstmt.clearParameters();
					try {pstmt.executeUpdate();}
					catch(Exception e) {out.println(e.toString());}
					ResultSet rs=pstmt.getGeneratedKeys();
					out.println("Height modified!" + "<div></div>");
				}
				if(!location.isEmpty()) {
					pstmt = con.prepareStatement("UPDATE `gallery`.`detail` SET `location`='"+ location +"' WHERE `image_id`='"+img_id+"';",Statement.RETURN_GENERATED_KEYS);
					pstmt.clearParameters();
					try {pstmt.executeUpdate();}
					catch(Exception e) {out.println(e.toString());}
					ResultSet rs=pstmt.getGeneratedKeys();
					out.println("Location modified!" + "<div></div>");
				}
				if(!description.isEmpty()) {
					pstmt = con.prepareStatement("UPDATE `gallery`.`detail` SET `description`='"+ description +"' WHERE `image_id`='"+img_id+"';",Statement.RETURN_GENERATED_KEYS);
					pstmt.clearParameters();
					try {pstmt.executeUpdate();}
					catch(Exception e) {out.println(e.toString());}
					ResultSet rs=pstmt.getGeneratedKeys();
					out.println("Description modified!" + "<div></div>");
				}
			}
			if(request.getParameter("modifyArtistButton") != null && !request.getParameter("modi_artist_id").isEmpty()){
            	String artist_id = request.getParameter("modi_artist_id");
            	String name = request.getParameter("modi_artist_name");
            	String birth = request.getParameter("modi_birth_year");
            	String country = request.getParameter("modi_country");
            	String description = request.getParameter("modi_artist_description");
				PreparedStatement pstmt;
				if(!name.isEmpty()) {
					pstmt = con.prepareStatement("UPDATE `gallery`.`artist` SET `name`='"+ name +"' WHERE `artist_id`='"+artist_id+"';",Statement.RETURN_GENERATED_KEYS);
					pstmt.clearParameters();
					try {pstmt.executeUpdate();}
					catch(Exception e) {out.println(e.toString());}
					ResultSet rs=pstmt.getGeneratedKeys();
					out.println("Name modified!" + "<div></div>");
				}
				if(!birth.isEmpty()) {
					pstmt = con.prepareStatement("UPDATE `gallery`.`artist` SET `birth_year`='"+ birth +"' WHERE `artist_id`='"+artist_id+"';",Statement.RETURN_GENERATED_KEYS);
					pstmt.clearParameters();
					try {pstmt.executeUpdate();}
					catch(Exception e) {out.println(e.toString());}
					ResultSet rs=pstmt.getGeneratedKeys();
					out.println("Birth year modified!" + "<div></div>");
				}
				if(!country.isEmpty()) {
					pstmt = con.prepareStatement("UPDATE `gallery`.`artist` SET `country`='"+ country +"' WHERE `artist_id`='"+artist_id+"';",Statement.RETURN_GENERATED_KEYS);
					pstmt.clearParameters();
					try {pstmt.executeUpdate();}
					catch(Exception e) {out.println(e.toString());}
					ResultSet rs=pstmt.getGeneratedKeys();
					out.println("Country modified!" + "<div></div>");
				}
				if(!description.isEmpty()) {
					pstmt = con.prepareStatement("UPDATE `gallery`.`artist` SET `description`='"+ description +"' WHERE `artist_id`='"+artist_id+"';",Statement.RETURN_GENERATED_KEYS);
					pstmt.clearParameters();
					try {pstmt.executeUpdate();}
					catch(Exception e) {out.println(e.toString());}
					ResultSet rs=pstmt.getGeneratedKeys();
					out.println("Description modified!" + "<div></div>");
				}
			}
			if(request.getParameter("modifyGalleryButton") != null && !request.getParameter("modi_gallery_id").isEmpty()){
            	String gallery_id = request.getParameter("modi_gallery_id");
            	String name = request.getParameter("modi_gallery_name");
            	String description = request.getParameter("modi_gallery_description");
				PreparedStatement pstmt;
				if(!name.isEmpty()) {
					pstmt = con.prepareStatement("UPDATE `gallery`.`gallery` SET `name`='"+ name +"' WHERE `gallery_id`='"+gallery_id+"';",Statement.RETURN_GENERATED_KEYS);
					pstmt.clearParameters();
					try {pstmt.executeUpdate();}
					catch(Exception e) {out.println(e.toString());}
					ResultSet rs=pstmt.getGeneratedKeys();
					out.println("Name modified!" + "<div></div>");
				}
				if(!description.isEmpty()) {
					pstmt = con.prepareStatement("UPDATE `gallery`.`gallery` SET `description`='"+ description +"' WHERE `gallery_id`='"+gallery_id+"';",Statement.RETURN_GENERATED_KEYS);
					pstmt.clearParameters();
					try {pstmt.executeUpdate();}
					catch(Exception e) {out.println(e.toString());}
					ResultSet rs=pstmt.getGeneratedKeys();
					out.println("Description modified!" + "<div></div>");
				}
			}

		}
		if(galleryClicked != 0){
			Statement stmt = con.createStatement();
			String selectp="SELECT * FROM image WHERE gallery_id="+ Integer.toString(galleryClicked);
			ResultSet rs=stmt.executeQuery(selectp);
			out.println("<div class=\"row\">");
			out.println("<div class=\"col-sm-7\">");
			out.println("<div class=\"row\">");
			int totalcount = 0;
			while (rs.next()) {
				out.println("<div class=\"col-sm-4\">");
				out.println("<div class=\"thumbnail\">");
				out.println(" <form method=\"post\"> <input class=\"imagepreview\"  name=\"image" + rs.getString("image_id") + "\" type=\"image\" src=\"" + rs.getString("link") + "\"/> </form>");
				out.println("Title:  " + rs.getString("title"));
				out.println("</div>");
				out.println("</div>");
				totalcount++;
			}
			out.println("</div>");
			out.println("<br><div style=\"text-align:center\"> Total numbers of images:  " + Integer.toString(totalcount) + "</div>");
			out.println("</div>");
			out.println("<div class=\"col-sm-5\">");
			if (imageClicked!=0){
				selectp="SELECT * FROM image as i, artist as a, detail as d WHERE i.artist_id = a.artist_id AND i.image_id = d.image_id AND i.image_id=" + Integer.toString(imageClicked);
				rs=stmt.executeQuery(selectp);
				rs.next();
				out.println("<div class=\"view\">");
				out.println("<img class=\"fullimg\" src=\"" + rs.getString("link") + "\">");
				out.println("<div class=\"info\">" + rs.getString("title") + "</div>");
				out.println("<div class=\"info\">" + "Image ID: " + rs.getString("image_id") + "</div>");
				out.println("<div id=\"artistLink\" class=\"link\">" + rs.getString("name") + "</div>");
				out.println("<div id=\"popArtist\" class=\"artistdetail\">" + "Artist ID: " + rs.getString("artist_id") + "&nbsp&nbsp&nbsp&nbsp" + "Name: " + rs.getString("name") + "&nbsp&nbsp&nbsp&nbsp"+ "Birth Year: " + rs.getString("birth_year")+ "&nbsp&nbsp&nbsp&nbsp"+ "Country: " + rs.getString("country")+ "&nbsp&nbsp&nbsp&nbsp"+ "Description: " + rs.getString("a.description") + "</div>");
				out.println("<div class=\"info\">" + rs.getString("location") + ", " + rs.getString("year") + "&nbsp&nbsp&nbsp&nbsp"+ rs.getString("width") + " * " + rs.getString("height") +  "</div>");
				out.println("<div class=\"info\">" + rs.getString("d.description") + "</div>");
				out.println("</div>");
			}
			out.println("</div>");
			out.println("</div>");

		}
		if (request.getParameter("listcontent") != null || request.getParameter("listgallery") != null) {
			add = "<form style=\"margin: 25px\" method=\"post\"><input type=\"submit\" name=\"listgallery\" value=\"List All Gallery\"/> </form>";
			out.println(add);
			if (request.getParameter("listgallery") != null){ 
				Statement stmt = con.createStatement();
				String selectg="SELECT * FROM gallery";
				ResultSet rs=stmt.executeQuery(selectg);
				out.println("<div class=\"row\">");
				while (rs.next()) {
					Statement stmtpic = con.createStatement();
					String getfirst="SELECT * FROM image WHERE gallery_id=" + rs.getString("gallery_id");
					ResultSet pics=stmtpic.executeQuery(getfirst);
					out.println("<div class=\"col-sm-4\">");
					out.println("<div class=\"thumbnail\">");
					if(pics.next()) out.println(" <form method=\"post\"> <input class=\"imagebutton\"  name=\"gallery" + rs.getString("gallery_id") + "\" type=\"image\" src=\"" + pics.getString("link") + "\"/> </form>");
					else out.println(" <form method=\"post\"> <input class=\"imagebutton\" name=\"gallery" + rs.getString("gallery_id") + "\" type=\"image\" src=\"" + "https://www.gumtree.com/static/1/resources/assets/rwd/images/orphans/a37b37d99e7cef805f354d47.noimage_thumbnail.png" + "\"/> </form>");
					out.println("Gallery ID:  " + rs.getString("gallery_id") + "<br>");
					out.println("Name:  " +  rs.getString("name") + "<br>" );
					out.println("Description:  " + rs.getString("description"));
					out.println("</div>");
					out.println("</div>");
				}
			out.println("</div>");
			}
		}
		
	 if (request.getParameter("addcontent") != null || request.getParameter("addGalleryButton") != null || request.getParameter("addArtistButton") != null || request.getParameter("addImageButton") != null ) 
	 	{
	 %>
	 			<div class ="addform"> 
	 				<form method="post"> 
	 					Name: <input name="name" type="text"> 
	 					Description: <input name="description" type="text"> 
	 					<input type="submit" name = "addGalleryButton" value="Create Gallery"/>
	 				</form>
	 			</div> 
	 			<div class ="addform"> 
	 				<form method="post"> 
	 					Name: <input name="name" type="text"> 
	 					Birth Year: <input name="birth_year" type="text"> 
	 					Country: <input name="country" type="text"> 
	 					Description: <input name="description" type="text"> 
	 					<input type="submit" name = "addArtistButton" value="Create Artist"/>
	 				</form>
	 			</div> 
	 			<div class ="addform"> 
	 				<form method="post"> 
	 					Title:   <input name="title" type="text"> 
	 					Gallery ID:   <input name="gallery_id" type="text"> 
	 					Artist ID: <input name="artist_id" type="text"> <br>
	 					Year: <input name="year" type="text"> 
	 					Type: <input name="type" type="text"> 
	 					Width: <input name="width" type="text"> <br>
	 					Height: <input name="height" type="text"> 
	 					Location: <input name="location" type="text"> 
	 					Description: <input name="description" type="text"> 
	 				<br>
	 				Link: <input name="link" type="text"> 
	 				<input type="submit" name = "addImageButton" value="Add By Link"/>
	 				</form>	
	 			</div>
	 			<div class="addform">
		 			<form method="post" action="/Gallery/UploadServlet" enctype="multipart/form-data">
		 				Title: <input name="title1" type="text"> 
	 					Gallery ID: <input name="gallery_id1" type="text"> 
	 					Artist ID: <input name="artist_id1" type="text"> 
	 					Year: <input name="year1" type="text"> 
	 					Type: <input name="type1" type="text"> 
	 					Width: <input name="width1" type="text"> 
	 					Height: <input name="height1" type="text"> 
	 					Location: <input name="location1" type="text"> 
	 					Description: <input name="description1" type="text">
	 					<br>
		    			Select a File:
		    			<input	style="margin-left : 0; margin-bottom: 1%;" type="file" name="uploadFile">
		    			<input type="submit" value="Add by Upload" />
					</form>
	 			</div>
	 			
		<%
	 		
            if(request.getParameter("addGalleryButton") != null && !request.getParameter("name").isEmpty() && !request.getParameter("description").isEmpty()){
            	String name = request.getParameter("name");
				String description = request.getParameter("description");
				PreparedStatement pstmt = con.prepareStatement("insert into gallery values(default,?,?)",Statement.RETURN_GENERATED_KEYS);
				pstmt.clearParameters();
				pstmt.setString(1, name);
				pstmt.setString(2, description);
				try {
					pstmt.executeUpdate();
				}
				catch(Exception e) {
					out.println("Duplicate entry");
					out.println(e.toString());
				}
				ResultSet rs=pstmt.getGeneratedKeys();
				while (rs.next()) {
				out.println("Successfully added. gallery_id:"+rs.getInt(1));
				}
			}
			 if(request.getParameter("addArtistButton") != null && request.getParameter("name")!="" && request.getParameter("birth_year")!=""  && request.getParameter("country")!="" && request.getParameter("description")!=""){
            	String name = request.getParameter("name");
            	String birth_year = request.getParameter("birth_year");
            	String country = request.getParameter("country");
				String description = request.getParameter("description");
				PreparedStatement pstmt = con.prepareStatement("insert into artist values(default,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
				pstmt.clearParameters();
				pstmt.setString(1, name);
				pstmt.setString(2, birth_year);
				pstmt.setString(3, country);
				pstmt.setString(4, description);
				try {
					pstmt.executeUpdate();
				}
				catch(Exception e) {
					out.println("Duplicate entry");
					out.println(e.toString());
				}
				ResultSet rs=pstmt.getGeneratedKeys();
				while (rs.next()) {
				out.println("Successfully added. artist_id:"+rs.getInt(1));
				}
			}

			if(request.getParameter("addImageButton") != null && request.getParameter("description")!="gallery_id"  && request.getParameter("link")!=""  && request.getParameter("artist_id")!=""  && request.getParameter("title")!=""){
            	String title = request.getParameter("title");
            	String link = request.getParameter("link");
            	String gallery_id = request.getParameter("gallery_id");
				String artist_id = request.getParameter("artist_id");
				String year = request.getParameter("year");
				String type = request.getParameter("type");
				String width = request.getParameter("width");
				String height = request.getParameter("height");
				String location = request.getParameter("location");
				String description = request.getParameter("description");
				PreparedStatement pstmt = con.prepareStatement("insert into image values(default,?,?,?,?,default)",Statement.RETURN_GENERATED_KEYS);
				pstmt.clearParameters();
				pstmt.setString(1, title);
				pstmt.setString(2, link);
				pstmt.setString(3, gallery_id);
				pstmt.setString(4, artist_id);
				try {
					pstmt.executeUpdate();
				}
				catch(Exception e) {
					out.println("Duplicate entry");
					out.println(e.toString());
				}
				ResultSet rs=pstmt.getGeneratedKeys();
				int iid=0;
				while (rs.next()) {
				iid = rs.getInt(1);
				out.println("Successfully added. image_id:"+rs.getInt(1));
				}
				pstmt = con.prepareStatement("UPDATE `gallery`.`image` SET `detail_id`='"+ Integer.toString(iid)+ "' WHERE `image_id`='"+ Integer.toString(iid)+ "';",Statement.RETURN_GENERATED_KEYS);
				pstmt.executeUpdate();
				pstmt = con.prepareStatement("insert into detail values(default,?,?,?,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
				pstmt.clearParameters();
				pstmt.setString(1, Integer.toString(iid));
				pstmt.setString(2, year);
				pstmt.setString(3, type);
				pstmt.setString(4, width);
				pstmt.setString(5, height);
				pstmt.setString(6, location);
				pstmt.setString(7, description);
				try {
					pstmt.executeUpdate();
				}
				catch(Exception e) {
					out.println("Duplicate entry");
					out.println(e.toString());
				}
			}
		}
	%>
	

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function() {
            $('#artistLink').click(function (){
            	$('#popArtist').fadeToggle(); 
            });
        });
	</script>
</body>
</html>

