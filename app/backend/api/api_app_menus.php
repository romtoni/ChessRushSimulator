<?
require_once('server.php');
require_once('lib_api.php');

$role_id = "";
if (isset($_GET["role_id"])) $role_id = $_GET["role_id"];

$data = list_menus($role_id);
echo $data;

function list_menus($role_id)
{
	global $conn;
	
	$cond = "";
	if ($role_id != "") $cond = "ROLE_ID = '$role_id'";
	
	if ($cond != "") $cond = "WHERE $cond";
	
	$menu_arr = array();
	$data = array();
	$no=0;
	$sql = "SELECT 
				ROLE_ID,
				MENU_ID,
				MENU_NAME,
				LINK,
				IS_SELECT
			FROM
				V_APP_MENU_ROLE
			$cond
			ORDER BY
				MENU_ID ASC";
	$q = oci_parse($conn, $sql);
	oci_execute($q);
	while($row = oci_fetch_assoc($q))
	{
		$no++;
		$role_id = $row["ROLE_ID"];
		$menu_id = $row["MENU_ID"];
		$menu_name = $row["MENU_NAME"];
		$link = $row["LINK"];
		$is_select = $row["IS_SELECT"];
		
		array_push($menu_arr, array("role_id" => $role_id,
									"menu_id" => $menu_id,
									"menu_name" => $menu_name,
									"link" => $link,
									"is_select" => $is_select)
					);
	}
	
	if (empty($menu_arr)) 
	{
		array_push($data, array("status" => "999",
								"message" => "FAILED : NO DATA FOUND",
								"data" => ""));
	}
	else
	{
		array_push($data, array("status" => "200",
								"message" => "SUCCESS",
								"data" => $menu_arr)
					);
	}
														
	
	return json_encode($data);
}

?>