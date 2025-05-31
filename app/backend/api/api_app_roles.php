<?
require_once('server.php');
require_once('lib_api.php');

$role_id = "";
if (isset($_GET["role_id"])) $role_id = $_GET["role_id"];

$data = list_roles($role_id);
echo $data;

function list_roles($role_id)
{
	global $conn;
	
	$cond = "";
	if ($role_id != "") $cond = "ROLE_ID = '$role_id'";
	
	if ($cond != "") $cond = "WHERE $cond";
	
	$role_arr = array();
	$data = array();
	$no=0;
	$sql = "SELECT 
				ROLE_ID,
				ROLE_NAME,
				ROLE_STATUS
			FROM
				APP_ROLE
			$cond
			ORDER BY
				ROLE_ID ASC";
	$q = oci_parse($conn, $sql);
	oci_execute($q);
	while($row = oci_fetch_assoc($q))
	{
		$no++;
		$role_id = $row["ROLE_ID"];
		$role_name = $row["ROLE_NAME"];
		$role_status = $row["ROLE_STATUS"];
		
		array_push($role_arr, array("role_id" => $role_id,
									"role_name" => $role_name,
									"role_status" => $role_status)
					);
	}
	
	if (empty($role_arr)) 
	{
		array_push($data, array("status" => "999",
								"message" => "FAILED : NO DATA FOUND",
								"data" => ""));
	}
	else
	{
		array_push($data, array("status" => "200",
								"message" => "SUCCESS",
								"data" => $role_arr)
					);
	}
														
	
	return json_encode($data);
}

?>