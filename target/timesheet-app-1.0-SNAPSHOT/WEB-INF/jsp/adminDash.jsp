<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gradient-to-r from-rose-100 via-pink-100 to-fuchsia-100 min-h-screen flex">

        <!-- Sidebar -->
        <aside class="w-64 bg-rose-700 text-white flex flex-col">
            <div class="p-6 text-2xl font-extrabold border-b border-rose-600">
                Admin Panel
            </div>
            <nav class="flex-1 p-4 space-y-4">
                <a href="viewApprove" class="block px-4 py-3 rounded-xl hover:bg-rose-600 transition">✅ Approve Timesheets</a>
                <a href="logout" class="block px-4 py-3 rounded-xl hover:bg-fuchsia-600 transition">🚪 Logout</a>
            </nav>
            <div class="p-4 text-sm text-rose-200 border-t border-rose-600">
                © 2025 TimeLogger
            </div>
        </aside>

        <!-- Main Content -->
        <main class="flex-1 p-10">
            <h1 class="text-4xl font-extrabold text-gray-800 mb-8">Welcome, Admin 👑</h1>

            <!-- Dashboard cards -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                <div class="bg-white shadow-2xl rounded-3xl p-8 hover:shadow-3xl transition">
                    <h2 class="text-xl font-semibold text-gray-700 mb-3">Approve Timesheets</h2>
                    <p class="text-gray-500 mb-6">Review and approve submitted timesheets for employees.</p>
                    <a href="viewApprove"
                       class="inline-block bg-rose-600 text-white px-6 py-3 rounded-xl font-semibold hover:bg-rose-700 transition-shadow shadow-md hover:shadow-lg">
                        Go
                    </a>
                </div>

                <div class="bg-white shadow-2xl rounded-3xl p-8 hover:shadow-3xl transition">
                    <h2 class="text-xl font-semibold text-gray-700 mb-3">Logout</h2>
                    <p class="text-gray-500 mb-6">End your session safely.</p>
                    <a href="logout"
                       class="inline-block bg-fuchsia-800 text-white px-6 py-3 rounded-xl font-semibold hover:bg-fuchsia-900 transition-shadow shadow-md hover:shadow-lg">
                        Logout
                    </a>

                </div>
            </div>
            <div class="mt-6">
                <p class="text-red-500 text-sm">
                    <%= (request.getAttribute("errMsg") != null) ? request.getAttribute("errMsg") : ""%>
                </p>
                <p class="text-green-500 text-sm">
                    <%= (request.getAttribute("sucMsg") != null) ? request.getAttribute("sucMsg") : ""%>
                </p>
            </div>
        </main>
    </body>
</html>
