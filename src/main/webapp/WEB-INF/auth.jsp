<div class="bg-white w-full max-w-md rounded-2xl shadow-2xl overflow-hidden mx-auto mt-12">

    <div class="flex border-b border-gray-200">
        <button id="loginTab" onclick="switchTab('login')"
                class="flex-1 py-4 text-center font-semibold text-indigo-600 border-b-2 border-indigo-600 focus:outline-none transition-colors cursor-pointer">
            Sign In
        </button>
        <button id="signupTab" onclick="switchTab('signup')"
                class="flex-1 py-4 text-center font-semibold text-gray-500 border-b-2 border-transparent hover:text-indigo-500 focus:outline-none transition-colors cursor-pointer">
            Sign Up
        </button>
    </div>

    <div class="p-8">
        <form id="loginForm" action="${pageContext.request.contextPath}/" method="POST" class="fade-in block">
            <div class="text-center mb-8">
                <h2 class="text-2xl font-bold text-gray-800">Welcome Back</h2>
                <p class="text-gray-500 text-sm mt-1">Please enter your details to sign in.</p>
            </div>

            <input type="hidden" name="action" value="login"/>

            <div class="space-y-5">
                <div>
                    <label for="loginEmail" class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
                    <input type="email" id="loginEmail" name="email" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                           placeholder="you@example.com">
                </div>

                <div>
                    <div class="flex justify-between items-center mb-1">
                        <label for="loginPassword" class="block text-sm font-medium text-gray-700">Password</label>
                        <a href="#" class="text-xs text-indigo-600 hover:text-indigo-800 font-medium">Forgot
                            password?</a>
                    </div>
                    <input type="password" id="loginPassword" name="password" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                           placeholder="*******">
                </div>


                <button type="submit"
                        class="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-semibold py-2.5 rounded-lg shadow-md hover:shadow-lg transition-all active:scale-[0.98] cursor-pointer">
                    Sign In
                </button>
            </div>
        </form>

        <form id="signupForm" action="${pageContext.request.contextPath}/" method="POST" class="fade-in hidden">
            <div class="text-center mb-8">
                <h2 class="text-2xl font-bold text-gray-800">Create an Account</h2>
                <p class="text-gray-500 text-sm mt-1">Join us today! It only takes a minute.</p>
            </div>
            <input type="hidden" name="action" value="signup"/>

            <div class="space-y-4">
                <div>
                    <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
                    <input type="text" id="name" name="name" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                           placeholder="John Doe">
                </div>

                <div>
                    <label for="signupEmail" class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
                    <input type="email" id="signupEmail" name="email" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                           placeholder="you@example.com">
                </div>

                <div>
                    <label for="signupPassword" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                    <input type="password" id="signupPassword" name="password" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                           placeholder="Create a strong password">
                </div>

                <button type="submit"
                        class="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-semibold py-2.5 rounded-lg shadow-md hover:shadow-lg transition-all mt-4 active:scale-[0.98] cursor-pointer">
                    Create Account
                </button>
            </div>

        </form>

    </div>
</div>

<%
    String alertMessage = (String) request.getAttribute("alertMessage");
    if (alertMessage != null && !alertMessage.trim().isEmpty()) {
%>
<script>
    // Trigger the browser alert
    alert("<%= alertMessage %>");
</script>
<% } %>

<script>

    function switchTab(tab) {
        const loginForm = document.getElementById('loginForm');
        const signupForm = document.getElementById('signupForm');
        const loginTab = document.getElementById('loginTab');
        const signupTab = document.getElementById('signupTab');

        const activeClasses = ['text-indigo-600', 'border-indigo-600'];
        const inactiveClasses = ['text-gray-500', 'border-transparent', 'hover:text-indigo-500'];

        if (tab === 'login') {
            loginForm.classList.remove('hidden');
            signupForm.classList.add('hidden');

            loginTab.classList.remove(...inactiveClasses);
            loginTab.classList.add(...activeClasses);

            signupTab.classList.remove(...activeClasses);
            signupTab.classList.add(...inactiveClasses);
        } else {

            signupForm.classList.remove('hidden');
            loginForm.classList.add('hidden');

            signupTab.classList.remove(...inactiveClasses);
            signupTab.classList.add(...activeClasses);

            loginTab.classList.remove(...activeClasses);
            loginTab.classList.add(...inactiveClasses);
        }
    }
</script>
