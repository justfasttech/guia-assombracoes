import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/role_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 600;

    return Scaffold(
      body: SingleChildScrollView(
        child: ResponsiveLayout(
          maxWidth: 700,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  'BETRAYAL',
                  style: GoogleFonts.cinzel(
                    fontSize: isWide ? 48 : 36,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    letterSpacing: 8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'AT HOUSE ON THE HILL',
                  style: GoogleFonts.cinzel(
                    fontSize: isWide ? 16 : 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                    letterSpacing: 6,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 60,
                  height: 2,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  'Guia de Assombrações',
                  style: GoogleFonts.cinzel(
                    fontSize: isWide ? 20 : 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 48),
                Text(
                  'Quem você é nesta noite?',
                  style: GoogleFonts.cinzel(
                    fontSize: isWide ? 22 : 18,
                    fontStyle: FontStyle.italic,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                if (isWide)
                  Row(
                    children: [
                      Expanded(
                        child: RoleCard(
                          title: 'Sobrevivente',
                          description: 'Consulte as regras e objetivos para os heróis',
                          icon: Icons.shield_outlined,
                          onTap: () => context.go('/sobrevivente'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: RoleCard(
                          title: 'Traidor',
                          description: 'Consulte as regras e objetivos para o traidor',
                          icon: Icons.auto_fix_high,
                          onTap: () => context.go('/traidor'),
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      RoleCard(
                        title: 'Sobrevivente',
                        description: 'Consulte as regras e objetivos para os heróis',
                        icon: Icons.shield_outlined,
                        onTap: () => context.go('/sobrevivente'),
                      ),
                      const SizedBox(height: 16),
                      RoleCard(
                        title: 'Traidor',
                        description: 'Consulte as regras e objetivos para o traidor',
                        icon: Icons.auto_fix_high,
                        onTap: () => context.go('/traidor'),
                      ),
                    ],
                  ),
                const SizedBox(height: 32),
                _buildEventsButton(context),
                const SizedBox(height: 12),
                _buildCardsButton(context),
                const SizedBox(height: 48),
                _buildInstructions(context),
                const SizedBox(height: 40),
                _buildFooter(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventsButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push('/eventos'),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFD4A017).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFD4A017).withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.auto_stories, color: Color(0xFFD4A017), size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Cartas de Evento',
                  style: GoogleFonts.cinzel(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFD4A017),
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFFD4A017), size: 22),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardsButton(BuildContext context) {
    const itemColor = Color(0xFF8D6E63);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push('/cartas'),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          decoration: BoxDecoration(
            color: itemColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: itemColor.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.inventory_2, color: itemColor, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Equipamentos & Presságios',
                  style: GoogleFonts.cinzel(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: itemColor,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: itemColor, size: 22),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Text(
            'Como usar este guia',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          _InstructionStep(
            number: '1',
            text: 'Descubra qual assombração foi ativada no jogo',
          ),
          const SizedBox(height: 16),
          _InstructionStep(
            number: '2',
            text: 'Selecione seu papel: Sobrevivente ou Traidor',
          ),
          const SizedBox(height: 16),
          _InstructionStep(
            number: '3',
            text: 'Encontre a assombração pelo número e leia as regras',
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'Este é um site não-oficial mantido por mim, sem fins lucrativos. '
        'Betrayal at House on the Hill é propriedade de Avalon Hill / Hasbro.',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 11,
              color: AppColors.textSecondary.withValues(alpha: 0.6),
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _InstructionStep extends StatelessWidget {
  final String number;
  final String text;

  const _InstructionStep({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(alpha: 0.2),
            border: Border.all(color: AppColors.primary),
          ),
          child: Text(
            number,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.primaryLight,
                ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
