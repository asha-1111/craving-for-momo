import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../models/product.dart';
import '../services/cart_service.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _hovering = false;
  late ProductOption _selectedOption;
  bool _justAdded = false;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.product.options.first;
  }

  void _handleAdd() {
    context.read<CartService>().addToCart(widget.product, _selectedOption);
    setState(() => _justAdded = true);
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) setState(() => _justAdded = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hovering ? -6 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.borderGlass),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowSoft,
              blurRadius: _hovering ? 24 : 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: AnimatedScale(
                duration: const Duration(milliseconds: 250),
                scale: _hovering ? 1.06 : 1.0,
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: AppColors.heroGradient,
                  ),
                  child: const Center(
                    child: Icon(Icons.ramen_dining_rounded, size: 48, color: AppColors.chocolate),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.name,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.darkText)),
                  const SizedBox(height: 4),
                  Text(widget.product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12.5, color: AppColors.mutedText, height: 1.4)),
                  const SizedBox(height: 12),
                  if (widget.product.options.length > 1)
                    _SizeSelector(
                      options: widget.product.options,
                      selected: _selectedOption,
                      onChanged: (opt) => setState(() => _selectedOption = opt),
                    ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        '৳${_selectedOption.priceTk.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.chocolate),
                      ),
                      const Spacer(),
                      _AddButton(justAdded: _justAdded, onTap: _handleAdd),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SizeSelector extends StatelessWidget {
  final List<ProductOption> options;
  final ProductOption selected;
  final ValueChanged<ProductOption> onChanged;

  const _SizeSelector({required this.options, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: options.map((opt) {
        final isSelected = opt.label == selected.label;
        return GestureDetector(
          onTap: () => onChanged(opt),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.chocolate : AppColors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: isSelected ? AppColors.chocolate : AppColors.borderGlass),
            ),
            child: Text(
              opt.label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.white : AppColors.darkText,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _AddButton extends StatelessWidget {
  final bool justAdded;
  final VoidCallback onTap;
  const _AddButton({required this.justAdded, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: justAdded ? AppColors.success : AppColors.darkText,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(justAdded ? Icons.check_rounded : Icons.add_rounded, size: 14, color: AppColors.white),
            const SizedBox(width: 4),
            Text(
              justAdded ? 'Added' : 'Add',
              style: const TextStyle(color: AppColors.white, fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
