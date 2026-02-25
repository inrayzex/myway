<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('practices', function (Blueprint $table) {

        $table->uuid('id')->primary();

        $table->foreignUuid('user_id')->constrained()->onDelete('cascade');

        $table->string('name', 100);

        $table->string('type', 50);

        $table->integer('goal_value')->nullable();

        $table->string('goal_unit', 20)->nullable();

        $table->integer('goal_days')->nullable();

        $table->string('period_type', 20)->default('daily');

        $table->json('days_of_week')->nullable();

        $table->time('reminder_time')->nullable();

        $table->json('reminder_channels')->nullable();

        $table->string('privacy', 20)->default('private');

        $table->boolean('is_active')->default(true);

        $table->timestamps();

    });

    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
         Schema::dropIfExists('practices');
    }
};
