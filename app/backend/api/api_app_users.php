<?
require_once('server.php');
require_once('lib_api.php');

$user_id="";
if (isset($_GET["user_id"])) $user_id = $_GET["user_id"];

$data = list_users($user_id);
echo $data;

function list_users($user_id)
{
	global $conn;
	
	$cond = "";
	if ($user_id != "") $cond = "USER_ID = '$user_id'";
	
	if ($cond != "") $cond = "WHERE $cond";
	
	$user_arr = array();
	$data = array();
	$no=0;
	$sql = "SELECT 
				USER_ID,
				USER_NAME,
				PASSWORD,
				ROLE_ID,
				EMAIL,
				USER_STATUS
			FROM
				APP_USER
			$cond
			ORDER BY
				USER_ID ASC";
	$q = oci_parse($conn, $sql);
	oci_execute($q);
	while($row = oci_fetch_assoc($q))
	{
		$no++;
		$user_id = $row["USER_ID"];
		$user_name = $row["USER_NAME"];
		$password = $row["PASSWORD"];
		$role_id = $row["ROLE_ID"];
		$email = $row["EMAIL"];
		$user_status = $row["USER_STATUS"];
		
		array_push($user_arr, array("user_id" => $user_id,
									"user_name" => $user_name,
									"password" => $password,
									"role_id" => $role_id,
									"email" => $email,
									"user_status" => $user_status
									)
					);
	}
	
	if (empty($user_arr)) 
	{
		array_push($data, array("status" => "999",
								"message" => "FAILED : NO DATA FOUND",
								"data" => ""));
	}
	else
	{
		array_push($data, array("status" => "200",
								"message" => "SUCCESS",
								"data" => $user_arr)
					);
	}
	
	return json_encode($data);
}
?>