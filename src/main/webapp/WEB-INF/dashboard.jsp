<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<main class="flex-1 max-w-[1600px] mx-auto w-full p-2 lg:p-4 overflow-hidden">
    <div class="grid grid-cols-1 lg:grid-cols-12 gap-4   h-full">

        <div class="lg:col-span-4 flex flex-col gap-4">
            <div class="bg-white border border-slate-200 rounded-3xl p-2 shadow-sm">
                <h2 class="text-lg font-bold text-slate-800 flex items-center gap-2 mb-4">
                    <svg class="w-5 h-5 text-indigo-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-width="2" d="M12 4v16m8-8H4"/></svg>
                    New Product
                </h2>

                <form action="${pageContext.request.contextPath}/dashboard" method="POST" class="space-y-4">
                    <input type="hidden" name="action" value="add">

                    <div>
                        <label class="text-[10px] font-bold text-slate-400 uppercase tracking-widest ml-1">Product Title</label>
                        <input type="text" name="name" required class="w-full bg-slate-50 rounded-xl px-4 py-3 border-none focus:ring-2 focus:ring-indigo-500 outline-none mt-1">
                    </div>

                    <div>
                        <label class="text-[10px] font-bold text-slate-400 uppercase tracking-widest ml-1">Product Image URL</label>
                        <input type="text" name="image" required class="w-full bg-slate-50 rounded-xl px-4 py-3 border-none focus:ring-2 focus:ring-indigo-500 outline-none mt-1" placeholder="https://example.com/image.jpg">
                    </div>

                    <div>
                        <label class="text-[10px] font-bold text-slate-400 uppercase tracking-widest ml-1">Description</label>
                        <textarea name="description" rows="3" class="w-full bg-slate-50 rounded-xl px-4 py-3 border-none focus:ring-2 focus:ring-indigo-500 outline-none mt-1 resize-none" placeholder="Brief details..."></textarea>
                    </div>

                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="text-[10px] font-bold text-slate-400 uppercase tracking-widest ml-1">Category</label>
                            <select name="category" class="w-full bg-slate-50 rounded-xl px-4 py-3 border-none outline-none mt-1">
                                <option>Electronics</option>
                                <option>Furniture</option>
                                <option>Apparel</option>
                            </select>
                        </div>
                        <div>
                            <label class="text-[10px] font-bold text-slate-400 uppercase tracking-widest ml-1">Quantity</label>
                            <input type="number" name="quantity" required class="w-full bg-slate-50 rounded-xl px-4 py-3 border-none outline-none mt-1">
                        </div>
                    </div>

                    <div>
                        <label class="text-[10px] font-bold text-slate-400 uppercase tracking-widest ml-1">Price ($)</label>
                        <input type="number" step="0.01" name="price" required class="w-full bg-slate-50 rounded-xl px-4 py-3 border-none outline-none mt-1">
                    </div>

                    <button type="submit" class="w-full py-4 bg-slate-900 text-white font-bold rounded-2xl hover:bg-indigo-600 transition-all shadow-lg active:scale-[0.98] mt-4">
                        Save Product
                    </button>
                </form>
            </div>
        </div>

        <div class="lg:col-span-8 flex flex-col h-full overflow-hidden">
            <div class="bg-white border border-slate-200 rounded-3xl shadow-sm overflow-hidden flex flex-col h-full">

                <div class="p-6 border-b border-slate-50 flex justify-between items-center bg-white shrink-0">
                    <div class="flex items-center gap-2">
                        <h3 class="font-bold text-slate-800 italic">Inventory List</h3>
                        <a href="${pageContext.request.contextPath}/products" class="flex items-center gap-2 px-4 py-2 text-[11px] font-bold text-indigo-600 border border-indigo-100 rounded-xl hover:bg-indigo-50 transition-colors">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                            </svg>
                            View Products
                        </a>
                    </div>
                    <span class="text-[10px] font-bold bg-slate-100 px-3 py-1 rounded-full text-slate-500 uppercase">${productList.size()} Items Total</span>
                </div>


                <div class="overflow-y-auto flex-1 custom-scrollbar">
                    <table class="w-full text-left border-collapse">
                        <thead class="sticky top-0 bg-white/95 backdrop-blur-sm z-10">
                        <tr class="text-slate-400 text-[10px] font-bold uppercase tracking-widest border-b border-slate-50">
                            <th class="px-8 py-4">Product Details</th>
                            <th class="px-8 py-4">Category</th>
                            <th class="px-8 py-4 text-center">In Stock</th>
                            <th class="px-8 py-4">Price</th>
                            <th class="px-8 py-4 text-right">Delete</th>
                        </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-50">
                        <c:forEach var="p" items="${productList}">
                            <tr class="hover:bg-slate-50/50 transition group">
                                <td class="px-8 py-5">
                                    <div class="font-bold text-slate-800">${p.name}</div>
                                    <div class="text-[11px] text-slate-400 leading-tight max-w-[300px] truncate">${p.description}</div>
                                </td>
                                <td class="px-8 py-5">
                                    <span class="text-[10px] font-bold text-slate-500 border border-slate-200 px-2 py-1 rounded uppercase">${p.category}</span>
                                </td>
                                <td class="px-8 py-5 text-center">
                                    <div class="flex items-center justify-center gap-2">
                                        <div class="w-1.5 h-1.5 rounded-full ${p.quantity < 5 ? 'bg-red-500 animate-pulse' : 'bg-green-500'}"></div>
                                        <span class="font-bold text-slate-700">${p.quantity}</span>
                                    </div>
                                </td>
                                <td class="px-8 py-5 font-bold text-slate-900">$${p.price}</td>
                                <td class="px-8 py-5 text-right">
                                    <form action="${pageContext.request.contextPath}/dashboard" method="POST" onsubmit="return confirm('Remove item?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="productId" value="${p.id}">
                                        <button type="submit" class="text-slate-300 hover:text-red-500 p-2 transition-colors">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                                            </svg>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <c:if test="${empty productList}">
                        <div class="p-20 text-center text-slate-400 italic">No products found.</div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</main>