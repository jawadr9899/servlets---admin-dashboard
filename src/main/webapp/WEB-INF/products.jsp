<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<main class="flex-1 max-w-[1600px] mx-auto w-full p-6 lg:p-8">

    <div class="flex flex-col md:flex-row md:items-center justify-between gap-6 mb-10">
        <div>
            <h1 class="text-3xl font-black text-slate-900 tracking-tight">Product Catalog</h1>
            <p class="text-slate-500 text-sm mt-1">Discover our latest inventory and collections.</p>
        </div>

        <div class="flex flex-col sm:flex-row gap-3 w-full md:w-auto">
            <div class="relative group">
                <svg class="w-5 h-5 absolute left-4 top-1/2 -translate-y-1/2 text-slate-400 group-focus-within:text-indigo-500 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                </svg>
                <input type="text" id="searchInput" placeholder="Search products..."
                       class="pl-12 pr-6 py-3.5 bg-white border border-slate-200 rounded-2xl w-full sm:w-[300px] outline-none focus:ring-4 focus:ring-indigo-500/10 focus:border-indigo-500 transition-all shadow-sm">
            </div>

            <select id="categoryFilter" class="px-6 py-3.5 bg-white border border-slate-200 rounded-2xl outline-none focus:ring-4 focus:ring-indigo-500/10 focus:border-indigo-500 shadow-sm text-slate-600 font-medium cursor-pointer">
                <option value="all">All Categories</option>
                <option value="Electronics">Electronics</option>
                <option value="Furniture">Furniture</option>
                <option value="Apparel">Apparel</option>
            </select>
        </div>
    </div>

    <div id="productGrid" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
        <c:forEach var="p" items="${productList}">
            <div class="product-card group bg-white border border-slate-100 rounded-[2rem] p-4 shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all duration-300"
                 data-name="${p.name.toLowerCase()}"
                 data-category="${p.category}">

                <div class="aspect-square w-full rounded-[1.5rem] bg-slate-50 overflow-hidden relative mb-6">
                    <img src="${p.imgURL}" alt="${p.name}" class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110">
                    <div class="absolute top-4 left-4">
                        <span class="px-3 py-1.5 bg-white/90 backdrop-blur-md rounded-full text-[10px] font-bold text-slate-700 uppercase tracking-widest shadow-sm">
                                ${p.category}
                        </span>
                    </div>
                </div>

                <div class="px-2 pb-2">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="font-bold text-slate-900 text-lg leading-tight">${p.name}</h3>
                        <span class="font-black text-indigo-600 text-lg">$${p.price}</span>
                    </div>
                    <p class="text-slate-400 text-sm leading-relaxed mb-6 line-clamp-2 h-10">
                            ${p.description}
                    </p>

                    <div class="flex items-center justify-between pt-4 border-t border-slate-50">
                        <div class="flex items-center gap-2">
                            <div class="w-2 h-2 rounded-full ${p.quantity > 0 ? 'bg-green-500' : 'bg-red-500'}"></div>
                            <span class="text-[11px] font-bold text-slate-500 uppercase">${p.quantity > 0 ? 'In Stock' : 'Out of Stock'}</span>
                        </div>
                        <button class="p-3 bg-slate-900 text-white rounded-xl hover:bg-indigo-600 active:scale-95 transition-all">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <div id="noResults" class="hidden py-20 text-center">
        <div class="bg-slate-50 w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-4">
            <svg class="w-10 h-10 text-slate-300" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" stroke-width="2"/></svg>
        </div>
        <h3 class="text-xl font-bold text-slate-800">No products found</h3>
        <p class="text-slate-400">Try adjusting your search or filters.</p>
    </div>
</main>

<script>
    const searchInput = document.getElementById('searchInput');
    const categoryFilter = document.getElementById('categoryFilter');
    const productCards = document.querySelectorAll('.product-card');
    const noResults = document.getElementById('noResults');

    function filterProducts() {
        const searchTerm = searchInput.value.toLowerCase();
        const selectedCategory = categoryFilter.value;
        let visibleCount = 0;

        productCards.forEach(card => {
            const name = card.getAttribute('data-name');
            const category = card.getAttribute('data-category');

            const matchesSearch = name.includes(searchTerm);
            const matchesCategory = selectedCategory === 'all' || category === selectedCategory;

            if (matchesSearch && matchesCategory) {
                card.style.display = 'block';
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        });

        noResults.classList.toggle('hidden', visibleCount > 0);
    }

    searchInput.addEventListener('input', filterProducts);
    categoryFilter.addEventListener('change', filterProducts);
</script>