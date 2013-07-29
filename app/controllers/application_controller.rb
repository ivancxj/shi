# coding: utf-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def notice_success(msg)
    flash[:notice] = msg
  end

  def notice_error(msg)
    flash[:notice] = msg
  end

  def notice_warning(msg)
    flash[:notice] = msg
  end

  def set_seo_meta(title = '',meta_keywords = '', meta_description = '')
    if title.length > 0
      @page_title = "#{title}"
    end
    @meta_keywords = meta_keywords
    @meta_description = meta_description
  end


  def shiyi_conn
    @@shiyi_conn ||= Faraday.new(:url => 'http://api.shiyimm.com') do |faraday|
      #faraday.request :multipart
      faraday.request  :url_encoded             # form-encode POST params
                                                #faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def shiyi_conn2
    @@shiyi_conn2 ||= Faraday.new(:url => 'http://api.shiyimm.com') do |faraday|
      #faraday.request :multipart
      faraday.request  :url_encoded             # form-encode POST params
                                                #faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def shiyi_conn3
    @@shiyi_conn3 ||= Faraday.new(:url => 'http://api.shiyimm.com') do |faraday|
      #faraday.request :multipart
      faraday.request  :url_encoded             # form-encode POST params
                                                #faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def shiyi_conn4
    @@shiyi_conn4 ||= Faraday.new(:url => 'http://api.shiyimm.com') do |faraday|
      #faraday.request :multipart
      faraday.request  :url_encoded             # form-encode POST params
                                                #faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def get_pre_goods_id(id)
    arr = get_ids
    index = arr.index(id.to_i)
    if index.nil?
      p 'todo 有错'
    else
      if index == 0
        nil
      else
        arr[index-1]
      end
    end
  end

  def get_next_goods_id (id)
    arr = get_ids
    len = arr.count
    index = arr.index(id.to_i)
    if index.nil?
      p 'todo 有错'
    else
      if index < len-1
        arr[index+1]
      else
        nil
      end
    end
  end

  def get_ids
    array = [1031, 1030, 1029, 1028, 1027, 1025, 1024, 1023, 1022, 1021, 1020, 1019, 1018, 1017, 1015, 1011, 915, 910, 907, 885, 854, 853, 852, 851, 850, 848, 847, 843, 838, 837, 828, 827, 826, 825, 823, 821, 819, 818, 817, 816, 814, 813, 809, 808, 807, 806, 805, 804, 803, 802, 798, 797, 795, 793, 788, 787, 786, 784, 783, 782, 772, 769, 1093, 1092, 1091, 1090, 1089, 1088, 1087, 1086, 1085, 1084, 1083, 1082, 1081, 1080, 1079, 1078, 1077, 1076, 1075, 1074, 1073, 1072, 1071, 1070, 993, 992, 991, 990, 989, 988, 981, 980, 979, 978, 977, 976, 975, 974, 973, 972, 971, 970, 969, 968, 967, 966, 965, 964, 963, 962, 961, 960, 959, 958, 957, 1421, 1420, 1419, 1418, 1416, 1415, 1414, 1413, 1412, 1411, 1410, 1409, 1408, 1407, 1406, 1405, 1404, 1403, 1402, 1401, 1400, 1008, 1006, 1005, 1004, 1002, 1000, 999, 998, 996, 995, 994, 1119, 1118, 1117, 1116, 1115, 1114, 1113, 1112, 1111, 1110, 1109, 1108, 1107, 1106, 1105, 1104, 1103, 1102, 1101, 1056, 1055, 1054, 1053, 1052, 1051, 1050, 1049, 1048, 1047, 1046, 1045, 1044, 1043, 1042, 1041, 1040, 1039, 1038, 1037, 1036, 1035, 1034, 1033, 1032, 987, 986, 985, 984, 983, 875, 874, 873, 872, 871, 870, 869, 868, 867, 866, 865, 864, 863, 862, 861, 860, 859, 857, 856, 855, 1385, 1384, 1383, 1382, 1381, 1380, 1379, 1378, 1377, 1376, 1375, 1374, 1373, 1372, 1371, 1370, 1369, 1368, 1367, 1366, 1365, 1364, 1363, 1362, 1361, 1360, 1359, 1358, 1357, 1356, 1355, 1354, 1353, 1352, 1351, 1350, 1349, 1348, 1347, 1346, 1310, 1309, 1308, 1307, 1306, 1305, 1304, 1303, 1302, 1301, 1300, 1299, 1298, 1296, 1295, 1294, 1293, 1292, 1291, 1290, 1289, 1288, 1287, 1286, 1285, 1284, 1283, 1282, 1281, 1280, 1279, 1278, 1277, 1276, 1275, 1274, 1273, 1272, 1271, 1270, 1269, 1268, 1267, 1266, 1265, 1264, 1263, 1262, 1261, 1260, 1259, 1258, 1257, 1256, 1255, 1254, 1253, 1252, 1251, 1250, 1249, 1248, 1247, 1246, 1245, 1244, 1243, 1242, 1241, 1240, 1239, 1238, 1237, 1236, 1235, 1234, 1233, 1232, 1231, 1230, 1229, 1228, 1227, 1226, 1225, 1224, 1223, 1222, 1221, 1220, 1219, 1218, 1217, 1216, 1215, 1214, 1213, 1212, 1211, 1210, 1209, 1208, 1207, 1206, 1205, 1204, 1203, 1202, 1201, 1200, 1199, 1198, 1197, 1196, 1195, 1194, 1193, 1192, 1191, 1190, 1189, 1188, 1187, 1186, 1185, 1184, 1183, 1182, 1181, 1180, 1179, 1178, 1177, 1176, 1175, 1174, 1173, 1172, 1171, 1170, 1169, 1168, 1167, 1166, 1165, 1164, 1163, 1162, 1161, 1160, 1159, 1158, 1157, 1156, 1155, 1154, 1153, 1152, 1151, 1150, 1149, 1148, 1147, 1146, 1145, 1144, 1143, 1142, 1141, 1140, 1139, 1138, 1137, 1136, 1135, 1134, 1133, 1132, 1131, 1130, 1129, 1128, 1127, 1126, 1125, 1124, 1123, 1122, 1121, 1120, 1388, 1387, 1386, 1100, 1099, 1098, 1097, 1096, 1095, 1094, 1473, 1472, 1471, 1470, 1469, 1468, 1399, 1398, 1397, 1395, 1394, 1393, 1392, 1391, 1390, 1389, 1330, 1329, 1328, 1327, 1326, 1325, 1324, 1323, 1322, 1321, 1320, 1319, 1318, 1317, 1316, 1315, 1314, 1313, 1312, 1311, 1068, 1067, 1066, 1063, 1062, 1061, 1060, 1058, 1057, 949, 948, 916, 903, 882, 834, 833, 832, 831, 830, 791, 780, 779, 778, 777, 764, 762, 761, 760, 759, 758, 757, 756, 744, 1444, 1443, 1442, 1441, 1440, 1439, 1438, 1437, 1436, 1435, 1434, 1433, 1432, 1431, 1430, 1429, 1428, 1427, 1426, 1425, 1424, 1423, 1422, 955, 954, 952, 951, 950]

  end
end
