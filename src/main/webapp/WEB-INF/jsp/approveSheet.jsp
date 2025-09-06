<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.*, java.time.format.DateTimeFormatter" %>
<%@ page import="com.armaan.timesheet.app.dto.TimeSheet" %>

<%
    TimeSheet ts = (TimeSheet) session.getAttribute("timesheet");

    LocalDate monday = ts.getWkStart();
    LocalDate sunday = ts.getWkEnd();
    float[] values = new float[5];

    values[0] = ts.getMon() / 60.0f;
    values[1] = ts.getTue() / 60.0f;
    values[2] = ts.getWed() / 60.0f;
    values[3] = ts.getThu() / 60.0f;
    values[4] = ts.getFri() / 60.0f;

    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd-MM-yyyy");
    String weekStart = monday.format(fmt);
    String weekEnd = sunday.format(fmt);

    String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday"};
    String[] dates = new String[5];
    for (int i = 0; i < 5; i++) {
        dates[i] = monday.plusDays(i).format(fmt);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Approve Timesheet</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-r from-rose-100 via-pink-100 to-fuchsia-100 min-h-screen flex items-center justify-center">

    <div class="bg-white rounded-3xl shadow-2xl w-full max-w-2xl p-8">
        <h2 class="text-2xl font-extrabold text-center text-gray-800 mb-6">
            Timesheet for Week <%= weekStart%> to <%= weekEnd%>
        </h2>

        <!-- Timesheet Table -->
        <table class="w-full border border-gray-300 rounded-xl overflow-hidden shadow-sm">
            <thead>
                <tr class="bg-gradient-to-r from-rose-600 to-fuchsia-600 text-white">
                    <th class="py-3 px-4 text-left">Day</th>
                    <th class="py-3 px-4 text-left">Date</th>
                    <th class="py-3 px-4 text-center">Hours</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-200">
                <% for (int i = 0; i < 5; i++) {%>
                <tr class="hover:bg-gray-50 transition">
                    <td class="py-2 px-4 font-medium text-gray-900"><%= days[i]%></td>
                    <td class="py-2 px-4 text-gray-700"><%= dates[i]%></td>
                    <td class="py-2 px-4 text-center">
                        <input type="number"
                               value="<%= values[i]%>"
                               readonly
                               class="border border-gray-300 rounded-md px-2 py-1 w-20 text-right bg-gray-100 text-gray-700">
                    </td>
                </tr>
                <% }%>

                <tr class="bg-gray-50">
                    <td class="py-2 px-4">Saturday</td>
                    <td class="py-2 px-4"><%= monday.plusDays(5).format(fmt)%></td>
                    <td class="py-2 px-4 text-center text-gray-500">Weekly Off</td>
                </tr>
                <tr class="bg-gray-50">
                    <td class="py-2 px-4">Sunday</td>
                    <td class="py-2 px-4"><%= sunday.format(fmt)%></td>
                    <td class="py-2 px-4 text-center text-gray-500">Weekly Off</td>
                </tr>
            </tbody>
        </table>

        <!-- Action Buttons -->
        <div class="flex justify-center gap-4 mt-8">
            <form action="approveReject" method="post" class="flex gap-4">
                <button type="submit" name="action" value="approve"
                        class="bg-green-600 text-white px-6 py-3 rounded-xl font-semibold shadow-md hover:bg-green-700 hover:shadow-lg transition">
                    Approve
                </button>

                <button type="submit" name="action" value="reject"
                        class="bg-red-600 text-white px-6 py-3 rounded-xl font-semibold shadow-md hover:bg-red-700 hover:shadow-lg transition">
                    Reject
                </button>

                <a href="viewApprove"
                        class="inline-block bg-rose-600 text-white px-6 py-3 rounded-xl font-semibold hover:bg-rose-700 transition-shadow shadow-md hover:shadow-lg">
                    Go Back
                </a>
            </form>
        </div>
    </div>

</body>
</html>
